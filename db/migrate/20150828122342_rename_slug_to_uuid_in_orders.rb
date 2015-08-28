class RenameSlugToUuidInOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :slug, "char(32)"
    enable_extension 'uuid-ossp'
    add_column :orders, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
