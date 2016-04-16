class AddFreeShipToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :free_ship, :boolean, default: false
  end
end
