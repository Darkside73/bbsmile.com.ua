class ApplicationController < ActionController::Base
  layout "layout_inner"

  http_basic_authenticate_with(Settings.http_auth.to_hash) if Settings.http_auth && Settings.http_auth.protect_front

  protect_from_forgery

  before_action :current_page_from_slug
  attr_reader :current_page
  helper_method :current_page, :cart

  protected

  def flashes_in_json
    { error: flash[:error], flash: render_to_string(partial: 'flashes.html') }
  end

  def current_page!
    current_page or raise ActiveRecord::RecordNotFound
  end

  def cart
    session[:cart] ||= Order.new
  end

  def reset_cart
    session[:cart] = nil
  end

  private

  def current_page_from_slug
    @current_page ||= Page.visible.find_by(url: params[:slug]) if params[:slug]
  end
end
