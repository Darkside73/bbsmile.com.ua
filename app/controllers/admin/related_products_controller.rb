class Admin::RelatedProductsController < Admin::ApplicationController
  respond_to :json, only: [:create, :destroy]
  respond_to :html, only: [:index, :show]

  def index
    @product = Product.find params[:product_id]
  end

  def create
    product = Product.find params[:product_id]
    related_product = product.related_products.build(related_product_params)
    related_product.save
    respond_with related_product, location: [:admin, related_product]
  end

  def show
    @related_product = RelatedProduct.find params[:id]
    respond_with(@related_product) do
      render(:show, layout: false) and return
    end
  end

  def destroy
    @related_product = RelatedProduct.find(params[:id])
    @related_product.destroy
    render json: {}
  end

  private

  def related_product_params
    params.require(:related_product).permit(:related_id, :type_of)
  end
end
