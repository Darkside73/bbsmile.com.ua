class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :article_theme, index: true
      t.timestamps
    end
  end
end
