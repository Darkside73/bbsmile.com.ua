class PagesController < ApplicationController

  rescue_from ActionView::MissingTemplate do
    raise ActiveRecord::RecordNotFound
  end

  def show
    render params[:page] unless @page = Page.visible.find_by_url(params[:page])
  end
end