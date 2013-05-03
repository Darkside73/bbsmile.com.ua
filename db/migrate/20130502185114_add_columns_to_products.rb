class AddColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price_old, :float
    add_column :products, :novelty, :boolean, default: false
    add_column :products, :topicality, :boolean, default: false
    add_column :products, :hit, :boolean, default: false
  end
end
