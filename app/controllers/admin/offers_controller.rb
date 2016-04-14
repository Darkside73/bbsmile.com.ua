class Admin::OffersController < Admin::ApplicationController
  respond_to :json
  respond_to :html, only: :index

  def create
    product = Product.find params[:product_id]
    offer = product.offers.build(offers_params)
    offer.save
    respond_with offer, location: [:admin, offer]
  end

  def index
    @product = Product.find(params[:product_id])
  end

  def available_products
    @products = Product.by_title(params[:q]).where.not(
      id: Offer.where(product_id: params[:product_id]).pluck(:product_offer_id)
    ).includes(:page, :variants).limit(10)
  end

  def sort
    offer = Offer.find params[:id]
    offer.insert_at params[:position].to_i
    head :ok
  end

  def destroy
    offer = Offer.find params[:id]
    offer.destroy
    render json: {}
  end

  private

  def offers_params
    params.require(:offer).permit(:product_offer_id, :price)
  end
end
