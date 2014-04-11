class ArticleThemesController < ApplicationController

  def show
    @theme = ArticleTheme.visible.by_url params[:slug]
  end
end
