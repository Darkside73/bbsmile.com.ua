class SearchController < ApplicationController

  def autocomplete
    brands = Brand.by_name(params[:q]).limit(5)
    variants = Variant.visible.by_sku(params[:q]).limit(5)
    products = Product.visible.by_title(params[:q]).limit(5)
    categories = Category.visible.by_title(params[:q]).limit(5)
    results = {
      brands: brands.as_json(only: [:id, :name]),
      products: products.as_json(
        methods: [:top_image], only: [:id],
        include: { page: { only: [:title, :name, :url] } }
      ),
      categories: categories.as_json(
        only: [:id],
        include: { page: { only: [:title, :name, :url] } }
      )
    }
    respond_to do |format|
      format.json { render json: results }
    end
  end
end