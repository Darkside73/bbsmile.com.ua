class Admin::SettingsController < Admin::ApplicationController

  def index
    @settings = SiteSettings.new
  end

  def update_multiple
    settings = SiteSettings.new settings_params
    settings.save
    redirect_to admin_settings_url, notice: I18n.t('flash.message.site_settings.updated')
  end

  private

  def settings_params
    params.require(:site_settings).permit(*SiteSettings::ATTRS)
  end
end
