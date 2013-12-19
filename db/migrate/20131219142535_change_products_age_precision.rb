class ChangeProductsAgePrecision < ActiveRecord::Migration
  def change
    change_column :products, :age_from, :float, precision: 3, scale: 2
    change_column :products, :age_to, :float, precision: 3, scale: 2
  end
end
