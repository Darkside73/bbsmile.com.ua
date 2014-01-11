class AddSexToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sex, :integer, default: Product::SEX[:for_any_gender]
  end
end
