class AddIndexes < ActiveRecord::Migration
  def change
    add_index :products, :position
    add_index :products, :category_id
    add_index :categories, :position
    add_index :variants, :position
    add_index :variants, :price
  end
end
