# TODO this is Product::Images controller actually
class Admin::ImagesController < Admin::ApplicationController

  def index
    @product = product
  end

  def new
    @product = product
  end

  def destroy
    image = Product::Image.find params[:id]
    image.destroy
    flash.now[:notice] = I18n.t 'flash.message.images.destroyed'
    render json: flashes_in_json
  end

  def sort
    image = Product::Image.find params[:id]
    image.insert_at params[:position].to_i
    render nothing: true
  end

  def create
    @product = product
    @image = @product.images.new params.fetch(:image, {}).permit(:attachment)
    if @image.save
      flash.now[:notice] = I18n.t 'flash.message.images.created'
      redirect_to [:admin, @product, :images]
    else
      # TODO forced reload for exclude builded image from "images" relation; need a better solution
      @product.images.reload
      render :index
    end
  end

  private
    def product
      Product.find params[:product_id]
    end
end
