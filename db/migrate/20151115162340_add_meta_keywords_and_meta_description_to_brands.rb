class AddMetaKeywordsAndMetaDescriptionToBrands < ActiveRecord::Migration
  def change
    change_table :brands do |t|
      t.column :meta_keywords, :string
      t.column :meta_description, :string
    end
  end
end
