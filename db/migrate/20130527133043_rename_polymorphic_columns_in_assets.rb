class RenamePolymorphicColumnsInAssets < ActiveRecord::Migration
  def change
    rename_column :assets, :imageable_id, :assetable_id
    rename_column :assets, :imageable_type, :assetable_type
  end
end
