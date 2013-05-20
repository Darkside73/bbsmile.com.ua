class RemoveVariantRelatedColumnsFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :price, :float
    remove_column :products, :available, :boolean
    remove_column :products, :sku, :string, index: true
    remove_column :products, :price_old, :float
  end
end
