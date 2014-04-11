class ArticlesController < ApplicationController

  def show
    @article = Article.visible.by_url params[:slug]
  end

  def index

  end
end
