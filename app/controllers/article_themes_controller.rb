class ArticleThemesController < ApplicationController

  def show
    @theme = ArticleTheme.visible.by_url params[:slug]
    @top_articles = @theme.articles.top
    @other_articles = @theme.articles.other
  end
end
