class ChangeCountDefaultValueInSuborders < ActiveRecord::Migration
  def change
    change_column :suborders, :count, :integer, default: 1
  end
end
