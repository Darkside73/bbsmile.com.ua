class ArticlesController < ApplicationController

  def show
    @article = Article.visible.by_url params[:slug]
  end
end
