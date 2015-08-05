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
        select o.id, variant_id, o.price, 1 from orders o
        join variants v on v.id = o.variant_id
      }
    end
  end
end
