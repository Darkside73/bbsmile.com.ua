class AddCountryToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :country, :string
  end
end
