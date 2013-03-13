class Admin::CategoriesController < Admin::ApplicationController

  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      redirect_to [:admin, @category], notice: 'Category created'
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes params[:category]
      redirect_to [:admin, @category], notice: 'Category updated'
    else
      render :edit
    end
  end

  def new_subcategory
    @category = Category.find params[:id]
    @subcategory = Category.new
  end

  def create_subcategory
    @category = Category.find params[:id]
    @subcategory = Category.new params[:category]
    @subcategory.parent = @category
    if @subcategory.save
      redirect_to [:admin, @subcategory], notice: 'Subcategory created'
    else
      render :new_subcategory
    end
  end
end
