class Admin::BrandsController < Admin::ApplicationController

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
    @brand.build_content
  end

  def create
    @brand = Brand.new brands_params
    if @brand.save
      redirect_to [:admin, :brands], notice: I18n.t('flash.message.brands.created')
    else
      render :new
    end
  end

  def edit
    @brand = Brand.find params[:id]
    @brand.build_content unless @brand.content
  end

  def update
    @brand = Brand.find params[:id]
    if @brand.update_attributes brands_params
      redirect_to [:admin, :brands], notice: I18n.t('flash.message.brands.updated')
    else
      render :edit
    end
  end

  def destroy
    @brand = Brand.find params[:id]
    @brand.destroy
    flash.now[:notice] = I18n.t 'flash.message.categories.destroyed.success'
    render json: flashes_in_json
  end

  private
    def brands_params
      params.require(:brand).permit(
        :name, content_attributes: [:id, :text]
      )
    end
end
