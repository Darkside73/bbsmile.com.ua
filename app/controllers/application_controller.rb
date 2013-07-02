class ApplicationController < ActionController::Base
  layout "layout_inner"

  http_basic_authenticate_with(name: 'admin', password: 'Y5petRup') if Rails.env == 'production'

  before_action :current_page_from_slug
  attr_reader :current_page

  protected

  def flashes_in_json
    { error: flash[:error], flash: render_to_string(partial: 'flashes.html') }
  end

  private

  def current_page_from_slug
    @current_page ||= Page.visible.find_by(url: params[:slug]) if params[:slug]
  end
end
