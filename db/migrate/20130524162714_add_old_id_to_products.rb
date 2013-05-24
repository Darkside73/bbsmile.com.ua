class AddOldIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :old_id, :integer
  end
end
