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
      redirect_to admin_categories_url, notice: 'Category created'
    else
      render :new
    end
  end
end
