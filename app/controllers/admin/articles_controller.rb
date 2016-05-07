class Admin::ArticlesController < Admin::ApplicationController

  def new
    theme = ArticleTheme.find params[:article_theme_id]
    @article = theme.articles.new
    @article.build_page
    build_article @article
  end

  def create
    theme = ArticleTheme.find params[:article_theme_id]
    @article = theme.articles.new article_params
    if @article.save
      redirect_to [:admin, theme], notice: I18n.t('flash.message.articles.created')
    else
      build_article @article
      render :new
    end
  end

  def edit
    @article = Article.find params[:id]
    build_article @article
  end

  def update
    @article = Article.find params[:id]
    if @article.update article_params
      redirect_to [:admin, @article.theme], notice: I18n.t('flash.message.articles.updated')
    else
      build_article @article
      render :edit
    end
  end

  def destroy
    article = Article.find params[:id]
    article.destroy
    flash.now[:notice] = I18n.t 'flash.message.articles.destroyed.success'
    render json: flashes_in_json
  end

  def related
    @article = Article.find params[:id]
  end

  private

  def article_params
    params.require(:article).permit(
      :article_theme_id, :top,
      page_attributes: [
        :id, :title, :name, :url, :url_old, :hidden, :meta_description
      ],
      content_attributes: [:id, :text],
      top_image_attributes: [:id, :attachment]
    )
  end

  def build_article(article)
    article.build_content unless article.content
    article.build_top_image unless article.top_image
  end
end
