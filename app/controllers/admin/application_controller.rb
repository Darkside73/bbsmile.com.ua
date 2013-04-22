class Admin::ApplicationController < ApplicationController
  layout 'admin/layouts/application'

  http_basic_authenticate_with(name: 'admin', password: 'Y5petRup') if Rails.env == 'production'

  def flashes_in_json
    { error: flash[:error], flash: render_to_string(partial: 'flashes') }
  end
end
