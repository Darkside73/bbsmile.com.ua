class ApplicationController < ActionController::Base
  include Webpacked::ControllerHelper
  layout "layout_inner"

  SKIP_AUTHENTICATION = %w(orders#api_callback)

  http_basic_authenticate_with Settings.http_auth.to_hash.merge(if: :need_authenticate?) if Settings.http_auth

  before_action :current_page_from_slug
  attr_reader :current_page
  helper_method :current_page, :seo_page, :cart
  webpacked_entry 'inner_page'

  protected

  def flashes_in_json
    { error: flash[:error], flash: render_to_string(partial: 'flashes.html') }
  end

  def current_page!
    current_page or raise ActiveRecord::RecordNotFound
  end

  def cart
    @cart ||= if session[:cart]
      order = Order.new(suborders_attributes: session[:cart])
      order.validate
      order
    else
      Order.new
    end
  end

  def reset_cart
    session[:cart] = nil
  end

  def seo_page
    @seo_page ||= begin
      seo_page = Seo::Page.new current_page
      seo_page.request = request
      seo_page
    end
  end

  protected

  def update_cart_in_session
    session[:cart] = cart.valid_suborders.map do |s|
      s.as_json(only: [:variant_id, :quantity], methods: :offer_id)
    end
  end

  private

  def current_page_from_slug
    @current_page ||= Page.visible.find_by(url: params[:slug]) if params[:slug]
  end

  def need_authenticate?
    Settings.http_auth.protect_front &&
      !SKIP_AUTHENTICATION.include?("#{controller_name}##{action_name}")
  end
end
