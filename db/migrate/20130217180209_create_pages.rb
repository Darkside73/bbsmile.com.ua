class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :pages, :url
  end
end
