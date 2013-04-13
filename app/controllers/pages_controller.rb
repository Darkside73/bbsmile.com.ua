class PagesController < ApplicationController

  rescue_from ActionView::MissingTemplate do
    raise ActiveRecord::RecordNotFound
  end

  def show
    @page = Page.visible.find_by_url(params[:slug])
    render params[:slug] and return unless @page
  end
end