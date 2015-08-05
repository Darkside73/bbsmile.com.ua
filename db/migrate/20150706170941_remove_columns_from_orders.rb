class RemoveColumnsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :variant_id, :integer
    remove_column :orders, :price, :float
  end
end
