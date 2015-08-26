class AddSlugToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :slug, "char(32)"
    reversible do
      execute "update orders set slug = md5(id::text)"
    end
  end
end
