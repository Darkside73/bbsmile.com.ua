class BrandsController < ApplicationController

  def show
    @brand = Brand.by_slug params[:name]
    @order = Order.new
    @order.build_user
    @products = @brand.products.visible.order(:category_id)
    @categories = @products.collect { |p| p.category.root }.uniq
    @categories = @products.collect { |p| p.category }.uniq if @categories.count == 1
    if params[:category_slug]
      @selected_category = Category.by_url!(params[:category_slug])
      @products = @products.reject { |p| !p.category.path_ids.include? @selected_category.id }
    end
  end
end
