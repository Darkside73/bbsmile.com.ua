class SearchController < ApplicationController

  def autocomplete
    brands = Brand.by_name(params[:q]).limit(5)
    variants = Variant.by_sku(params[:q]).limit(5)
    products = Page.visible.products.by_title(params[:q]).limit(5)
    categories = Page.visible.categories.by_title(params[:q]).limit(5)
    results = {
      brands: brands.as_json(only: [:id, :name]),
      products: products.as_json(
        only: [:title, :name, :url],
        include: { pageable: { only: [:id], methods: [:top_image] } }
      )
    }
    respond_to do |format|
      format.json { render json: results }
    end
  end
end