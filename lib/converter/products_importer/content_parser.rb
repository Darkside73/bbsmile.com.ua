module Converter
  class ProductsImporter

    class ContentParser
      include ActionView::Helpers
      ALLOWED_HTML = { tags: %w(p ul ol li strong b em i), attributes: [] }

      def initialize(content_path)
        @content_path = content_path
        @logger = Logger.new(STDOUT)
      end

      def content
        @content ||= File.exists?(@content_path) ? create_content(File.read(@content_path)) : nil
      end

      # TODO this method should be static or extracted to module... lack some ruby basics for do that now:(
      def clean_html(text)
        str = sanitize(text, ALLOWED_HTML).gsub(/&nbsp;/i, ' ')
        # TODO something more clever?
        2.times { str.gsub!(/<\w+>[\s$]*<\/\w+>/i, '') }
        str
      end

      private
        def create_content(text)
          Content.new text: clean_html(text)
        end
    end
  end
end