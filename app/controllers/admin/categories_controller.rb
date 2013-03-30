class Admin::CategoriesController < Admin::ApplicationController

  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
    @category.build_page
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
    @subcategory.build_page
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

  def sort
    category = Category.find params[:id]
    category.insert_at params[:position].to_i
    render nothing: true
  end

  def destroy
    @category = Category.find params[:id]
    begin
      @category.destroy
    rescue Ancestry::AncestryException
      flash.now[:error] = "Forbidden. Category has children"
    end
    respond_to do |format|
      format.html { redirect_to @category }
      format.js
    end
  end
end
