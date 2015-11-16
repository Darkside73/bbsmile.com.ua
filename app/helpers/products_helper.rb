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

  def sizes_button
    if [135, 205, 202, 148].include?(@product.category.root_id)
      extend ActiveSupport::Inflector
      brand_slug = transliterate(@product.brand.name).downcase
      content_tag :p do
        link_to "Таблица размеров", article_path("tablitsa-razmerov-#{brand_slug}"), class: "btn btn-info"
      end
    end
  end
end
