class AddAgeFromAgeToToProducts < ActiveRecord::Migration
  def change
    add_column :products, :age_from, :float, precision: 2, scale: 1
    add_column :products, :age_to, :float, precision: 2, scale: 1
  end
end
