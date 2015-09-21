class AddDiscountToSuborder < ActiveRecord::Migration
  def change
    add_column :suborders, :discount, :float, precision: 8, scale: 2, default: 0
  end
end
