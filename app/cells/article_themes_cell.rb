class ArticleThemesCell < Cell::ViewModel

  def show
    @current_theme = model
    @themes = ArticleTheme.visible
    render
  end
end
