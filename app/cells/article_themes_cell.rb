class ArticleThemesCell < Cell::Rails

  def display(current_theme = nil)
    @current_theme = current_theme
    @themes = ArticleTheme.visible
    render
  end
end
