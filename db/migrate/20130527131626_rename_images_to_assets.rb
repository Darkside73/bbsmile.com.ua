class RenameImagesToAssets < ActiveRecord::Migration
  def change
    rename_table :images, :assets
  end
end
