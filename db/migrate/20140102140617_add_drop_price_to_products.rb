class AddDropPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :drop_price, :boolean, default: false
  end
end
