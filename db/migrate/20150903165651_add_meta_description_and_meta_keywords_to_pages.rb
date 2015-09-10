class AddMetaDescriptionAndMetaKeywordsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :meta_keywords, :string
    add_column :pages, :meta_description, :string
  end
end
