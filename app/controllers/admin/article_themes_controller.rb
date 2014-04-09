class Admin::ArticleThemesController < Admin::ApplicationController

  def index
    @themes = ArticleTheme.includes(:page)
  end

  def show
    @theme = ArticleTheme.find params[:id]
  end

  def new
    @theme = ArticleTheme.new
    @theme.build_page
  end

  def create
    @theme = ArticleTheme.new theme_params
    if @theme.save
      redirect_to [:admin, @theme], notice: I18n.t('flash.message.article_themes.created')
    else
      render :new
    end
  end

  def edit
    @theme = ArticleTheme.find params[:id]
  end

  def update
    @theme = ArticleTheme.find params[:id]
    if @theme.update_attributes theme_params
      redirect_to [:admin, @theme], notice: I18n.t('flash.message.article_themes.updated')
    else
      render :edit
    end
  end

  def sort
    theme = ArticleTheme.find params[:id]
    theme.insert_at params[:position].to_i
    render nothing: true
  end

  def destroy
    theme = ArticleTheme.find params[:id]
    begin
      theme.destroy
      flash.now[:notice] = I18n.t 'flash.message.article_themes.destroyed.success'
    rescue
      flash.now[:error] = I18n.t 'flash.message.article_themes.destroyed.forbidden'
    end
    render json: flashes_in_json
  end

  private

  def theme_params
    params.require(:article_theme).permit(
      page_attributes: [:id, :title, :name, :url, :url_old, :hidden]
    )
  end
end
