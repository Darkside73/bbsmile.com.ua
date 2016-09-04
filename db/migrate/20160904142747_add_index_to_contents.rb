class AddIndexToContents < ActiveRecord::Migration[5.0]
  def change
    add_index :contents, :contentable_id
    add_index :contents, :contentable_type
  end
end
