class BrandsController < ApplicationController

  def show
    @brand = Brand.by_slug params[:name]
    @order = Order.new
    @order.build_user
    @products = @brand.products.visible
                      .includes(:category, :page, :variants, :images, :brand)
                      .order(:category_id)
    @categories = Category.includes(:page).find @products.map(&:category).map(&:root_id).uniq
    @categories = @products.map(&:category).uniq if @categories.count == 1
    if params[:category_slug]
      @selected_category = Category.by_url!(params[:category_slug])
      @products = @products.reject {
        |p| !p.category.path_ids.include? @selected_category.id
      }
    end
  end
end
