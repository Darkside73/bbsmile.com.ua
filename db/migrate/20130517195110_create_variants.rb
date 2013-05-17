class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :name
      t.boolean :master, default: false
      t.float :price, precision: 8, scale: 2
      t.float :price_old, precision: 8, scale: 2
      t.string :sku
      t.boolean :available, nil: false, default: true
      t.integer :position, nil: false, default: 0
      t.references :product, index: true

      t.timestamps
    end
  end
end
