class AddStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer, default: Order.statuses[:placed]
  end
end
