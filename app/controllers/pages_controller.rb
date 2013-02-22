class PagesController < ApplicationController

  before_filter :find_page_or_render_view

  rescue_from ActionView::MissingTemplate do
    raise ActiveRecord::RecordNotFound
  end

  def index

  end

  private
    def find_page_or_render_view
      render params[:path] unless @page = Page.find_by_url(params[:path])
    end
end