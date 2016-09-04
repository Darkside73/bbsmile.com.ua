class AddIndexToAssets < ActiveRecord::Migration[5.0]
  def change
    add_index :assets, :assetable_id
    add_index :assets, :assetable_type
    add_index :assets, :type
  end
end
