class AddTotalCorrectionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_correction, :decimal, precision: 8, scale: 2, nil: false, default: 0
  end
end
