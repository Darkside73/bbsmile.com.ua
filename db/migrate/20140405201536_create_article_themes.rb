class CreateArticleThemes < ActiveRecord::Migration
  def change
    create_table :article_themes do |t|
      t.integer :position, nil: false
      t.timestamps
    end
  end
end
