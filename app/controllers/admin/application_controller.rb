class Admin::ApplicationController < ApplicationController
  layout 'admin/layouts/application'

  http_basic_authenticate_with(Settings.http_auth.to_hash) if Settings.http_auth

end
