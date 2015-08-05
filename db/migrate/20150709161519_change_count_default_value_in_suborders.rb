class ChangeCountDefaultValueInSuborders < ActiveRecord::Migration
  def change
    reversible do
      change_column :suborders, :count, :integer, default: 1
    end
  end
end
