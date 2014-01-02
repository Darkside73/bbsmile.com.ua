module ProductsHelper

  def variant_image_url(variant, style = nil)
    image = if variant.image.present?
      variant.image
    elsif variant.master?
      @product.images.first
    end
    if image
      image.url(style)
    else
      'no_image.png'
    end
  end

  def product_variants
    @product.variants.includes(:image, :product)
  end

  def product_share_data
    {
      url:   product_page_url(@product.url),
      title: @product.title,
      image: @product.top_image? ?
               URI.join(request.url, @product.top_image(:medium)) : ''
    }
  end

  def seo_product_title
    "#{@product.title} #{sprintf(Settings.seo.product_title, @product.category.title)}"
  end

  def seo_product_description
    description = @product.description.present? ? @product.description : @product.properties
    if description
      sanitize_for_meta_desciption description
    else
      "#{@product.title} #{@product.category.title} #{Settings.seo.product_description}"
    end
  end

  private

  def sanitize_for_meta_desciption(text)
    text.gsub! /(<\/\w+>)(<\w+)/, '\1 \2'
    text = strip_tags(text).strip.gsub(/(\r|\n)/, ' ').gsub(/\s+/, ' ')
    truncate text, length: 160
  end
end
