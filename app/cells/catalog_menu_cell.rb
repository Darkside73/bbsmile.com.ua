class CatalogMenuCell < Cell::ViewModel
  include ApplicationHelper

  def show
    @categories = Category.arrange
    render
  end
end
