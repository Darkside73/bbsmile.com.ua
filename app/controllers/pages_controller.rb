class PagesController < ApplicationController

  rescue_from ActionView::MissingTemplate do
    raise ActiveRecord::RecordNotFound
  end

  def show
    @page = Page.visible.find_by_url(params[:page])
    render params[:page] and return unless @page
    @category = @page.pageable and render('categories/show') and return if @page.pageable.is_a? Category
  end
end