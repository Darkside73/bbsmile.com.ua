module Converter
  class ProductsImporter

    class ContentParser
      include ActionView::Helpers
      ALLOWED_TAGS = %(p ul ol li strong b em i)

      def initialize(content_path)
        @content_path = content_path
        @logger = Logger.new(STDOUT)
      end

      def content
        @content ||= File.exists?(@content_path) ? create_content(File.read(@content_path)) : nil
      end

      private
        def create_content(text)
          Content.new text: clean_html(text)
        end

        def clean_html(text)
          sanitize text
        end
    end
  end
end