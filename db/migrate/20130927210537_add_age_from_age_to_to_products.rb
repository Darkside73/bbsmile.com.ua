class AddAgeFromAgeToToProducts < ActiveRecord::Migration
  def change
    add_column :products, :age_from, :integer
    add_column :products, :age_to, :integer
  end
end
