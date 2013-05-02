class Admin::ImagesController < Admin::ApplicationController

  def create
    @product = Product.find params[:product_id]
    image = @product.images.build image_params
    if image.save
      flash.now[:notice] = I18n.t 'flash.message.images.created'
      redirect_to [:admin, @product]
    else
      render [:admin, @product]
    end
  end

  def destroy
    image = Image.find params[:id]
    image.destroy
    flash.now[:notice] = I18n.t 'flash.message.images.destroyed'
    render json: flashes_in_json
  end

  def sort
    image = Image.find params[:id]
    image.insert_at params[:position].to_i
    render nothing: true
  end

  private
    def image_params
      # TODO avoid missing "image" parameter exception
      params.require(:image).permit(:asset)
    end
end
