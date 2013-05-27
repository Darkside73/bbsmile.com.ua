module ProductsHelper

  def variant_image_url(variant, style = nil)
    image = if variant.image.present?
      variant.image
    elsif variant.master?
      variant.product.images.first
    end
    image.url(style) if image
  end
end
