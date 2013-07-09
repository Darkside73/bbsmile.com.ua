class Admin::ProductContentsController < Admin::ApplicationController
  include Admin::Contentable

  def new
    @product = Product.find params[:product_id]
  end

  def create
    @product = Product.find params[:product_id]
    create_for @product
  end

  def edit
    @product = @content.contentable
  end

  def update
    @product = @content.contentable
    update_content
  end
end
