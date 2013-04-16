class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.float :price
      t.boolean :available
      t.string :sku, index: true
      t.references :category
      t.timestamps
    end
  end
end
