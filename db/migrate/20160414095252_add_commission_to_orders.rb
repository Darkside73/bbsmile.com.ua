class AddCommissionToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :commission, :float, precision: 8, scale: 2
  end
end
