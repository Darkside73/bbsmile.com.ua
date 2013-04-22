class Admin::ProductsController < Admin::ApplicationController

  def index
    @products = Product.includes(:page).recent(10).to_a
  end

  def new
    @product = Product.new
    @product.build_page
    @leaf_categories = Category.includes(:page).where(leaf: true).to_a
  end

  def create
    @product = Product.new products_params
    if @product.save
      redirect_to [:admin, :products], notice: I18n.t('flash.message.products.created')
    else
      render :new
    end
  end

  # def edit
  #   @category = Category.find params[:id]
  # end

  # def update
  #   @category = Category.find params[:id]
  #   if @category.update_attributes category_params
  #     redirect_to redirect_location, notice: I18n.t('flash.message.categories.updated')
  #   else
  #     render :edit
  #   end
  # end

  # def sort
  #   category = Category.find params[:id]
  #   category.insert_at params[:position].to_i
  #   render nothing: true
  # end

  # def destroy
  #   @category = Category.find params[:id]
  #   begin
  #     @category.destroy
  #     flash.now[:notice] = I18n.t 'flash.message.categories.destroyed.success'
  #   rescue Ancestry::AncestryException
  #     flash.now[:error] = I18n.t 'flash.message.categories.destroyed.forbidden'
  #   end
  # end

  private
    def products_params
      params.require(:product).permit(
        :sku, :price, :category_id, page_attributes: [:title, :url, :hidden]
      )
    end
end
