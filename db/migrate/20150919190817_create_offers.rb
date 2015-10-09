class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :product, index: true, nil: false
      t.integer :product_offer_id, index: true, nil: false
      t.float :price, precision: 8, scale: 2, nil: false
      t.integer :position, nil: false
    end
    add_foreign_key :offers, :products, column: :product_offer_id, primary_key: :id
  end
end
