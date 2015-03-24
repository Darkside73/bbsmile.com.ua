class AddTopToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :top, :boolean, default: false
  end
end
