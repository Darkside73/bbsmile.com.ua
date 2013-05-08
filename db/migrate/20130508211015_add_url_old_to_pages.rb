class AddUrlOldToPages < ActiveRecord::Migration
  def change
    add_column :pages, :url_old, :string
    change_table :pages do |t|
      t.index :url_old, unique: true
    end
  end
end
