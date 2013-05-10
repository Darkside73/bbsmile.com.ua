require 'csv'

module Converter

  class ProductsImporter
    attr_writer :categories_map

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
        source['url_old'].sub!('http://bbsmile.com.ua/', '')
        Product.create!(
          page_attributes: {
            title: source['title'], url: source['url_old'], url_old: source['url_old']
          },
          category: Page.find_by!(title: category_title).pageable, price: source['price'],
          brand: Brand.find_or_create_by(name: source['brand'])
        ) unless Page.find_by(url: source['url_old'])
      end
  end
end