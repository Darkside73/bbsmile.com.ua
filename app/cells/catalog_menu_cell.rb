class CatalogMenuCell < Cell::Rails
  helper ApplicationHelper

  def display
    @categories = Category.arrange
    render
  end
end
