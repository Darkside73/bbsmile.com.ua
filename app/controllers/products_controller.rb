class ProductsController < ApplicationController
  before_action :create_order
  helper_method :gallery_for

  def show
    @product = current_page.pageable
  end

  def novelties
    special_products_for :novelties
  end

  def discounts
    special_products_for :discounts
  end

  def hits
    special_products_for :hits
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

  private

  def create_order
    @order = Order.new
    @order.build_user
  end

  def special_products_for(scope)
    @special_products_path = "#{scope}_path".to_sym
    @products = Product.send(scope).last_updated(36)
    root_ids = @products.map(&:category).map(&:root_id).uniq
    @categories = Category.includes(:page).find root_ids
    if params[:category_slug]
      @selected_category = Category.by_url!(params[:category_slug])
      category_ids = @selected_category.has_children? ? @selected_category.child_ids
                                                      : @selected_category
      @products = @products.where(category_id: category_ids)
    end
  end
end
