class Admin::CategoryContentsController < Admin::ApplicationController
  include Admin::Contentable

  def new
    @category = Category.find params[:category_id]
  end

  def create
    @category = Category.find params[:category_id]
    create_for @category
  end

  def edit
    @category = @content.contentable
  end

  def update
    @category = @content.contentable
    update_content
  end
end
