class ApplicationController < ActionController::Base
  layout "layout_inner"

  http_basic_authenticate_with(name: 'admin', password: 'Y5petRup') if Rails.env == 'production'

  protected
    def pageable_from_slug
      Page.visible.find_by!(url: params[:slug]).pageable
    end
end
