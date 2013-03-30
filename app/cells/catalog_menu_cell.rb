class CatalogMenuCell < Cell::Rails
  helper ApplicationHelper

  def display
    @categories = Category.includes(:page).arrange
    render
  end
end
