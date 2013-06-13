class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :user_name
      t.string :user_phone
      t.references :user
      t.float :price, precision: 8, scale: 2
      t.references :variant
      t.text :notes

      t.timestamps
    end
  end
end
