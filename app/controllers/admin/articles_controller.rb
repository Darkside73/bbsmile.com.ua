class Admin::ArticlesController < Admin::ApplicationController

  def new
    theme = ArticleTheme.find params[:article_theme_id]
    @article = theme.articles.new
    @article.build_page
    @article.build_content
  end

  def create
    theme = ArticleTheme.find params[:article_theme_id]
    @article = theme.articles.new article_params
    if @article.save
      redirect_to [:admin, theme], notice: I18n.t('flash.message.articles.created')
    else
      render :new
    end
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes article_params
      redirect_to [:admin, @article.theme], notice: I18n.t('flash.message.articles.updated')
    else
      render :edit
    end
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    flash.now[:notice] = I18n.t 'flash.message.articles.destroyed.success'
    render json: flashes_in_json
  end

  private

  def article_params
    params.require(:article).permit(
      page_attributes: [:id, :title, :name, :url, :url_old, :hidden],
      content_attributes: [:id, :text]
    )
  end
end
