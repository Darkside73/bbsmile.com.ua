class Admin::ImagesController < Admin::ApplicationController

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
end
