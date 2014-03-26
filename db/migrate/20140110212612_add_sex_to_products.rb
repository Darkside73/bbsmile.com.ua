class AddSexToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sex, :integer, default: Product.sexes[:for_any_gender]
  end
end
