class PageTypeConstraint

  def initialize(type)
    @type = type
  end

  def matches?(request)
    slug = request.fullpath.sub(/^[\/]*/, '')
    page = Page.visible.find_by(url: slug)
    page && page.pageable.is_a?(@type)
  end
end