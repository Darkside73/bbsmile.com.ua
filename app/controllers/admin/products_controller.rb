class Admin::ProductsController < Admin::ApplicationController
  respond_to :json, only: :available_for_relation
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
    @product = Product.new product_params
    @category = @product.category
    if @product.save
      redirect_to [:admin, @product], notice: I18n.t('flash.message.products.created')
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
    if @product.update product_params
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
    flash.now[:notice] = I18n.t 'flash.message.products.destroyed'
    render json: flashes_in_json
  end

  def tags
    tags = Tag.where(params[:q])
    tags.map { |tag| { text: tag.name, id: tag.name } }
    respond_to do |format|
      format.json { render json: tags }
    end
  end

  def bulk_move
    dest_category = Category.find params[:dest_category_id]
    Product.where(id: params[:ids]).map do |product|
      product.category = dest_category
      product.save
    end
    flash.now[:notice] = I18n.t(
      'flash.message.products.moved',
      dest_category_path:  admin_category_path(dest_category),
      dest_category_title: dest_category.title
    )
    render json: flashes_in_json
  end

  def content
    @product = Product.find params[:id]
  end

  def properties
    @product = Product.find params[:id]
  end

  def available_for_relation
    already_related_ids = RelatedProduct.where(product_id: params[:id])
                                        .pluck(:related_id)
    already_related_ids << params[:id]
    items = Product.by_title(params[:q])
                   .where.not(id: already_related_ids)
                   .limit(5)

    results = items.inject([]) do |results, item|
      results << { id: item.id, name: item.title, url: url_for([:admin, item]) }
    end

    respond_with(results.to_json)
  end

  private
    def product_params
      params.require(:product).permit(
        :category_id, :brand_id, :age, :sex,
        :novelty, :hit, :drop_price, :video, :tag_list, :properties,
        page_attributes: [:id, :title, :name, :url, :url_old, :hidden],
        variants_attributes: [[:id, :sku, :price, :price_old, :available]],
        images_attributes: [[:attachment]]
      )
    end

    def assign_leaf_categories
      @leaf_categories = Category.leaves.to_a
    end

    def category_for_new_product(category_id)
      Category.leaves.find category_id
    end
end
