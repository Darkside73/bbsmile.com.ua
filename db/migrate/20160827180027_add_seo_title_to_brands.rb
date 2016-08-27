class AddSeoTitleToBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :seo_title, :string
  end
end
