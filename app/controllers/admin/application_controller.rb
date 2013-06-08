class Admin::ApplicationController < ApplicationController
  layout 'admin/layouts/application'

  def flashes_in_json
    { error: flash[:error], flash: render_to_string(partial: 'flashes') }
  end
end
