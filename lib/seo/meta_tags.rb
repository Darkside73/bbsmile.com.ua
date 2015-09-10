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

  def fallback_description_for_article
    article = @page.pageable
    description = article.description
    if description.present?
      sanitize_description description
    else
      default_meta "description"
    end
  end

  def fallback_keywords
    @page.title.split
  end

  def to_hash
    { description: description, keywords: keywords }
  end

  private

  def meta_tag_for(type)
    return default_meta(type) unless @page

    meta = ''
    {
      "meta_#{type}" => @page,
      "fallback_#{type}_for_#{@page.pageable.class.name}".downcase => self,
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
    text.gsub! /(<\/\w+>)(<\w+)/, '\1 \2'
    text = strip_tags(text).strip.gsub(/(\r|\n)/, ' ').gsub(/\s+/, ' ')
    truncate text, length: 160
  end
end
