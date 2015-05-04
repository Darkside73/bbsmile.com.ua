class CreateRelatedPages < ActiveRecord::Migration
  def change
    rename_table :related_products, :related_pages
    rename_column :related_pages, :product_id, :page_id
  end
end
