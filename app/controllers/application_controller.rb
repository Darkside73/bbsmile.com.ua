class ApplicationController < ActionController::Base
  layout "layout_inner"

  protect_from_forgery

  http_basic_authenticate_with(Settings.http_auth.to_hash) if Settings.http_auth

  before_action :current_page_from_slug
  attr_reader :current_page
  helper_method :current_page

  protected

  def flashes_in_json
    { error: flash[:error], flash: render_to_string(partial: 'flashes.html') }
  end

  private

  def current_page_from_slug
    @current_page ||= Page.visible.find_by(url: params[:slug]) if params[:slug]
  end
end
