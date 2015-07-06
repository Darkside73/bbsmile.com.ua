class CreateSuborders < ActiveRecord::Migration
  def change
    create_table :suborders do |t|
      t.references :order, index: true, foreign_key: true
      t.references :variant, index: true, foreign_key: true
      t.float :price, precision: 8, scale: 2
      t.integer :count
    end
    reversible do
      execute %{
        insert into suborders (order_id, variant_id, price, count)
        select id, variant_id, price, 1 from orders
      }
    end
  end
end
