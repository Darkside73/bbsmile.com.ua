class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, nil: false
      t.timestamps
    end
  end
end
