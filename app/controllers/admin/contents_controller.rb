class Admin::ContentsController < Admin::ApplicationController

  def new
    @product = Product.find params[:product_id]
  end

  def create
    @product = Product.find params[:product_id]
    @content = @product.build_content content_params
    if @content.save
      flash.now[:notice] = I18n.t 'flash.message.content.saved'
      redirect_to [:content, :admin, @product]
    else
      render :new
    end
  end

  def edit
    @content = Content.find params[:id]
    @product = @content.contentable
  end

  def update
    @content = Content.find params[:id]
    @product = @content.contentable
    if @content.update(content_params)
      flash.now[:notice] = I18n.t 'flash.message.content.saved'
      redirect_to [:content, :admin, @product]
    else
      render :edit
    end
  end

  private
    def content_params
      params.require(:content).permit(:text)
    end
end
