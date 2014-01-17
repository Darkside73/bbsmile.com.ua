class CreateRelatedProducts < ActiveRecord::Migration
  def change
    create_table :related_products do |t|
      t.references :product, index: true
      t.integer :related_id, index: true
      t.integer :type_of
      t.timestamps
    end
  end
end
