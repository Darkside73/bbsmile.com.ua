class AddUrlUniqueIndexToPage < ActiveRecord::Migration
  def change
    remove_index :pages, :url
    change_table :pages do |t|
      t.index :url, unique: true
    end
  end
end
