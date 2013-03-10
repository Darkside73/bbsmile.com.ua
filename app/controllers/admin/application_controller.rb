class Admin::ApplicationController < ApplicationController
  layout 'admin/layouts/application'

  # http_basic_authenticate_with(name: 'admin', password: 'Y5petRup') if Rails.env == 'production'
end
