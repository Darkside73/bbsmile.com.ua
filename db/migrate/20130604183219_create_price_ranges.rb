class CreatePriceRanges < ActiveRecord::Migration
  def change
    create_table :price_ranges do |t|
      t.integer :from
      t.integer :to
      t.references :category, index: true
    end
  end
end
