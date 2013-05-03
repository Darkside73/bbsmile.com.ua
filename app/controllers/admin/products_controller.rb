class Admin::ProductsController < Admin::ApplicationController

  before_action :assign_leaf_categories, expect: [:index, :show, :destroy]

  def index
    @products = Product.includes(:page).recent(10).to_a
  end

  def show
    @product = Product.find params[:id]
  end

  def new
    @product = Product.new
    @product.build_page
  end

  def new_in_category
    @category = category_for_new_product(params[:id])
    @product = Product.new
    @product.build_page
    render :new
  end

  def create
    @category = Category.find(params[:product][:category_id])
    @product = Product.new products_params
    if @product.save
      redirect_to [:admin, @category], notice: I18n.t('flash.message.products.created')
    else
      render :new
    end
  end

  def edit
    @product = Product.find params[:id]
    @category = @product.category
  end

  def update
    @product = Product.find params[:id]
    if @product.update_attributes products_params
      redirect_to [:admin, @product], notice: I18n.t('flash.message.products.updated')
    else
      render :edit
    end
  end

  def sort
    product = Product.find params[:id]
    product.insert_at params[:position].to_i
    render nothing: true
  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    flash.now[:notice] = I18n.t 'flash.message.products.destroy'
    render json: flashes_in_json
  end

  private
    def products_params
      params.require(:product).permit(
        :sku, :price, :price_old, :category_id, :brand_id,
        :available, :novelty, :topicality, :hit,
        page_attributes: [:title, :url, :hidden],
        images_attributes: [[:asset]]
      )
    end

    def assign_leaf_categories
      @leaf_categories = Category.includes(:page).where(leaf: true).to_a
    end

    def category_for_new_product(category_id)
      Category.find_by! leaf: true, id: category_id
    end
end
