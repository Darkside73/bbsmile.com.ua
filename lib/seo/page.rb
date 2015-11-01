module Seo

  class Page
    attr_accessor :request

    class Dummy < Struct.new(:title)
    end

    def initialize(page)
      @page = page || Dummy.new
    end

    def meta_tags
      MetaTags.new(@page).to_hash.merge(open_graph)
    end

    def title= title
      @page.title = title if @page.is_a? Dummy
    end

    def image
      if @page.respond_to? :pageable
        case @page.pageable
        when Product then request.base_url + @page.pageable.top_image.to_s
        when Article then request.base_url + @page.pageable.top_image.try(:url).to_s
        end
      end
    end

    def open_graph
      {
        og: {
          title: @page.title,
          image: image,
          url: request.original_url
        }
      }
    end
  end
end
