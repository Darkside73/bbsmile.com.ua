class BrandsController < ApplicationController

  def show
    @brand = Brand.by_slug params[:name]
    @order = Order.new
    @order.build_user
    @products = @brand.products.visible
                      .includes(:category, :page, :variants, :images, :brand)
                      .order(:category_id)
    @categories = @brand.categories(@products)
    if params[:category_slug]
      @selected_category = Category.by_url!(params[:category_slug])
      @products = @products.reject {
        |p| !p.category.path_ids.include? @selected_category.id
      }
    end
  end

  protected

  def seo_page
    @seo_page ||= begin
      seo_page = Seo::Page.new @brand
      seo_page.request = request
      seo_page
    end
  end
end
