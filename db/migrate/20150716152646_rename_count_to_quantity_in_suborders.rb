class RenameCountToQuantityInSuborders < ActiveRecord::Migration
  def change
    rename_column :suborders, :count, :quantity
  end
end
