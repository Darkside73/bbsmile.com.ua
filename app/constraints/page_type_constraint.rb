class PageTypeConstraint

  def initialize(type)
    @type = type
  end

  def matches?(req)
    page = Page.visible.find_by(url: req.params['slug'])
    page && page.pageable.is_a?(@type)
  end
end
