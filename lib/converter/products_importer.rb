require 'csv'
require 'action_dispatch/testing/test_process'

module Converter

  class ProductsImporter
    include ActionDispatch::TestProcess

    attr_writer :categories_map
    attr_accessor :data_base_path

    MIN_IMAGE_WIDTH  = 160
    MIN_IMAGE_HEIGHT = 160

    def initialize(csv_file)
      @csv = CSV.parse csv_file, headers: true, col_sep: ';'
      @logger = Logger.new(STDOUT)
    end

    def import
      @csv.each do |row|
        source = row.to_hash
        category_title = @categories_map[source['category']]
        unless category_title.blank?
          begin
            create_product_from_source(source, category_title)
          rescue ActiveRecord::RecordInvalid => e
            @logger.info "Could not import product id #{source['id']}: #{e}"
          rescue ActiveRecord::RecordNotFound => e
            @logger.info "Could not find category #{category_title}"
          end
        else
          @logger.info "Could not find mapping for #{source['category']}"
        end
      end
    end

    private
      def create_product_from_source(source, category_title)
        return if Page.find_by(url_old: source['url_old'])
        source['url_old'].sub!('http://bbsmile.com.ua/', '')
        product = Product.create!(
          page_attributes: {
            title: source['title'], url: source['url_old'], url_old: source['url_old']
          },
          category: Page.find_by!(title: category_title).pageable,
          variants_attributes: [{price: source['price']}],
          brand: Brand.find_or_create_by(name: source['brand'])
        )
        create_images(product, source)
      end

      def create_images(product, source)
        Dir.glob("#{@data_base_path}/images/#{source['id']}/*") do |file_path|
          dimensions = Paperclip::Geometry.from_file(file_path)
          if dimensions.width >= MIN_IMAGE_WIDTH && dimensions.height >= MIN_IMAGE_HEIGHT
            content_type = "image/#{File.extname(file_path).sub('.', '')}"
            product.images.create asset: fixture_file_upload(file_path, content_type)
          end
        end
      end
  end
end