class PagesController < ApplicationController

  def index
    @page = Page.find_by_url! params[:path]
  end
end