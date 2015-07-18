class PopulateOrderTotalColumn < ActiveRecord::Migration
  def change
    reversible do
      execute "update orders o set total = s.price * s.quantity from suborders s where s.order_id = o.id"
    end
  end
end
