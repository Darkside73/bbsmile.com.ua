class ApplicationController < ActionController::Base
  layout "layout_inner"

  protected
    def pageable_from_slug
      Page.visible.find_by!(url: params[:slug]).pageable
    end
end
