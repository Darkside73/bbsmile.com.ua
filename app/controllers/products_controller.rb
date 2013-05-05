class ProductsController < ApplicationController

  helper_method :gallery_for

  def show
    @product = pageable_from_slug
  end

  def gallery_for(product)
    return unless product.images.any?
    first_image = product.images.first
    other_images = product.images.slice(1..product.images.count)
    render_to_body partial: 'gallery',
                   locals: {
                     first_image: first_image,
                     other_images: other_images,
                     product: product
                   }
  end
end
