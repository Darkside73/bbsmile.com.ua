class Admin::ProductsController < Admin::ApplicationController

  before_action :assign_leaf_categories, expect: [:index, :show, :destroy]

  def index
    @products = Product.includes(:page).recent(10).to_a
  end

  def show
    @product = Product.find params[:id]
    @image = @product.images.new
    @content = @product.content || @product.build_content
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
    @content = @product.content || @product.build_content
  end

  def update
    @product = Product.find params[:id]
    if @product.update products_params
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

  def create_image
    @product = Product.find params[:id]
    @content = @product.content || @product.build_content
    @image = @product.images.new image_params
    if @image.save
      flash.now[:notice] = I18n.t 'flash.message.images.created'
      redirect_to [:admin, @product]
    else
      render :show
    end
  end

  def save_content
    @product = Product.find params[:id]
    # TODO remove duplication by using AJAX (thumbs up!) or separate pages or before action callback
    @image = @product.images.new
    @content = @product.content || @product.build_content
    if @content.update params.require(:content).permit(:text)
      flash.now[:notice] = I18n.t 'flash.message.content.saved'
      redirect_to [:admin, @product]
    else
      render :edit
    end
  end

  def tags
    tags = ActsAsTaggableOn::Tag.where('name LIKE ?', "%#{params[:q]}%").limit(5)
    tags.map! { |tag| { text: tag.name, id: tag.name } }
    respond_to do |format|
      format.json { render json: tags }
    end
  end

  private
    def products_params
      params.require(:product).permit(
        :sku, :price, :price_old, :category_id, :brand_id,
        :available, :novelty, :topicality, :hit, :video, :tag_list,
        page_attributes: [:title, :url, :hidden],
        images_attributes: [[:asset]]
      )
    end

    def image_params
      params.fetch(:image, {}).permit(:asset)
    end

    def assign_leaf_categories
      @leaf_categories = Category.includes(:page).where(leaf: true).to_a
    end

    def category_for_new_product(category_id)
      Category.find_by! leaf: true, id: category_id
    end
end
