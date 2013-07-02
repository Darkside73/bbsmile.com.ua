class PagesController < ApplicationController

  rescue_from ActionView::MissingTemplate do
    raise ActiveRecord::RecordNotFound
  end

  def show
    @page = current_page
    render "pages/#{params[:slug]}" and return unless @page
  end
end