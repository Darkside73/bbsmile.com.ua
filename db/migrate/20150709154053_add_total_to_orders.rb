class AddTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total, :float, precision: 8, scale: 2
  end
end
