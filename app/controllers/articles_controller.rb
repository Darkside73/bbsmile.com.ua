class ArticlesController < ApplicationController

  def show
    @article = Article.visible.by_url! params[:slug]
  end

  def index
    @top_articles = Article.top
    @other_articles = Article.other.limit(5)
  end
end
