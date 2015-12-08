class Seo::MetaTags
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper

  def initialize(page)
    @page = page
  end

  def description
    meta_tag_for "description"
  end

  def keywords
    meta_tag_for "keywords"
  end

  def fallback_description_for_product
    product = @page.pageable
    description = product.description.present? ? product.description
                                               : product.properties
    if description
      sanitize_description description
    else
      [
        product.title,
        product.category.title,
        Settings.seo.product_description
      ].join(" ")
    end
  end

  def fallback_description
    if @page.respond_to?(:description)
      return sanitize_description @page.description
    end

    if @page.respond_to?(:pageable)
      pageable = @page.pageable
      if pageable.respond_to?(:description) && pageable.description.present?
        return sanitize_description pageable.description
      end
    end

    default_meta "description"
  end

  def fallback_keywords
    @page.title.split
  end

  def to_hash
    { description: description }
  end

  private

  def meta_tag_for(type)
    case @page
    when -> (o) { o.respond_to?(:pageable) }
      page_type = @page.pageable.class.name.downcase
    when -> (o) { o.is_a? Brand }
      page_type = "page"
    else
      return default_meta(type)
    end

    meta = ''
    {
      "meta_#{type}" => @page,
      "fallback_#{type}_for_#{page_type}" => self,
      "fallback_#{type}" => self
    }.each do |method, object|
      if object.respond_to? method
        meta = object.send(method)
        break if meta.present?
      end
    end

    meta = default_meta type unless meta.present?

    meta
  end

  def default_meta(type)
    {
      description: Settings.seo.defaults.description,
      keywords:    Settings.seo.defaults.keywords
    }.fetch(type.to_sym)
  end

  def sanitize_description(text)
    return '' unless text
    text.gsub! /(<\/\w+>)(<\w+)/, '\1 \2'
    text = strip_tags(text).strip.gsub(/(\r|\n)/, ' ').gsub(/\s+/, ' ')
    truncate text, length: 160
  end
end
