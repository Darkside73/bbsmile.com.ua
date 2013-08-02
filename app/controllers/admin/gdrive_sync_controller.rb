require 'google_drive'

class Admin::GdriveSyncController < Admin::ApplicationController

  def prices
    session = GoogleDrive.login *Settings.gdrive.auth.to_hash.values

  end
end
