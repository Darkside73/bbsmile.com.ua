module Converter
  class ProductsImporter

    class ContentParser

      def initialize(content_path)
        @content_path = content_path
        @logger = Logger.new(STDOUT)
      end

      def content
        @content ||= File.exists?(@content_path) ? Content.create(text: File.read(@content_path)) : nil
      end
    end
  end
end