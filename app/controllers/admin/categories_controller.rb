class Admin::CategoriesController < Admin::ApplicationController
  before_action :populate_parent_param, only: [:update]

  def index
    @categories = Category.includes(:page).roots
  end

  def show
    @category = Category.find params[:id]
    @products = @category.products
    @subcategories = @category.children.includes(:page)
    # TODO refactoring with "except" scope
    @dest_categories = Category.leaves.reject { |c| c == @category }
    # @dest_categories = Category.leaves.except(@category)
  end

  def new
    @category = Category.new
    @category.build_page
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to redirect_location, notice: I18n.t('flash.message.categories.created')
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
    @parent_categories = Category.includes(:page).where(leaf: false).to_a
    # TODO refactoring with "except" scope
    @parent_categories.reject! {|c| c == @category }
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes category_params
      redirect_to redirect_location, notice: I18n.t('flash.message.categories.updated')
    else
      render :edit
    end
  end

  def new_subcategory
    @category = Category.find params[:id]
    @subcategory = Category.new
    @subcategory.build_page
  end

  def create_subcategory
    @category = Category.find params[:id]
    @subcategory = Category.new category_params
    @subcategory.parent = @category
    if @subcategory.save
      redirect_to [:admin, @category], notice: I18n.t('flash.message.categories.subcategory_created')
    else
      render :new_subcategory
    end
  end

  def sort
    category = Category.find params[:id]
    category.insert_at params[:position].to_i
    render nothing: true
  end

  def destroy
    @category = Category.find params[:id]
    begin
      @category.destroy
      flash.now[:notice] = I18n.t 'flash.message.categories.destroyed.success'
    rescue Ancestry::AncestryException
      flash.now[:error] = I18n.t 'flash.message.categories.destroyed.forbidden'
    end
    render json: flashes_in_json
  end

  def content
    @category = Category.find params[:id]
  end


  private
    def category_params
      params.require(:category).permit(
        :leaf, :parent_id,
        page_attributes: [
          :id, :title, :name, :url, :url_old, :hidden,
          :meta_keywords, :meta_description
        ]
      )
    end

    def redirect_location
      [:admin, @category.is_root? ? :categories : @category.parent]
    end

    def populate_parent_param
      params[:parent] = Category.find(category_params[:parent_id]) if category_params[:parent_id].present?
    end
end
