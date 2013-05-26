require 'csv'
require 'action_dispatch/testing/test_process'
require 'converter/products_importer/content_parser'

module Converter

  class Results
    COUNTERS = [:created, :existed, :invalid, :category_not_found, :mapping_not_found]
    attr_accessor :all

    def initialize
      COUNTERS.each { |method| instance_variable_set(:"@#{method}", 0) }
    end

    COUNTERS.each do |method|
      attr_reader method
      define_method :"#{method}!" do
        instance_variable_set(:"@#{method}", instance_variable_get(:"@#{method}") + 1)
      end
    end

    def show
      puts "All records in price: #{all}"
      puts "Created products: #{created}"
      puts "Existed products: #{existed}"
      puts "Invalid rows: #{invalid}"
      puts "Category not found problems: #{category_not_found}"
      puts "Mapping not found problems: #{mapping_not_found}"
    end
  end

  class ProductsImporter
    include ActionDispatch::TestProcess

    attr_writer   :categories_map, :logger
    attr_accessor :data_base_path
    attr_reader   :results

    MIN_IMAGE_WIDTH  = 160
    MIN_IMAGE_HEIGHT = 160

    def initialize(csv_file)
      @csv = CSV.parse csv_file, headers: true, col_sep: ';'
      @stdout_logger = @logger = Logger.new(STDOUT)
      @results = Results.new
    end

    def import
      results.all = @csv.count
      @csv.each_with_index do |row, index|
        source = row.to_hash
        category_title = @categories_map[source['category']]
        unless category_title.blank?
          begin
            product = create_product_from_source(source, category_title)
          rescue ActiveRecord::RecordInvalid => e
            @logger.info "Could not import product id #{source['id']}: #{e}"
            results.invalid!
          rescue ActiveRecord::RecordNotFound => e
            @logger.info "Could not find category #{category_title}"
            results.category_not_found!
          end
        else
          @logger.info "Could not find mapping for #{source['category']}"
          results.mapping_not_found!
        end
        @stdout_logger.info "processed: #{index + 1}" if (index + 1) % 150 == 0
      end
    end

    private
      def create_product_from_source(source, category_title)
        source['url_old'].sub!('http://bbsmile.com.ua/', '')
        if Page.find_by(url_old: source['url_old'])
          results.existed!
          return
        end

        category = Page.find_by!(title: category_title).pageable
        raise ActiveRecord::RecordNotFound if category.leaf?

        product = Product.create!(
          page_attributes: {
            title: source['title'], url: source['url_old'], url_old: source['url_old']
          },
          category: category,
          old_id: source['id'],
          video: source['video'],
          variants_attributes: [{price: source['price']}],
          brand: Brand.find_or_create_by(name: source['brand'])
        )

        create_images(product)
        create_content(product)

        results.created!
      end

      def create_images(product)
        Dir.glob("#{@data_base_path}/images/#{product.old_id}/*") do |file_path|
          dimensions = Paperclip::Geometry.from_file(file_path)
          if dimensions.width >= MIN_IMAGE_WIDTH && dimensions.height >= MIN_IMAGE_HEIGHT
            content_type = "image/#{File.extname(file_path).sub('.', '')}"
            product.images.create asset: fixture_file_upload(file_path, content_type)
          end
        end
      end

      def create_content(product)
        content = ContentParser.new("#{@data_base_path}/content/#{product.old_id}.html").content
        if content
          content.contentable = product
          content.save
        end
      end
  end
end