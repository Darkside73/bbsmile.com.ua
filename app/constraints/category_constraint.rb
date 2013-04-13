class CategoryConstraint

  def self.matches?(request)
    page = self.page_from_request request
    page && page.pageable.is_a?(Category)
  end

  private
    def self.page_from_request(request)
      slug = self.strip_leading_slash request.fullpath
      page = Page.visible.find_by_url(slug)
    end

    def self.strip_leading_slash(str)
      return str[1..str.size] if str[0] == '/'
      str
    end
end