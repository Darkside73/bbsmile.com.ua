class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :product, index: true
      t.integer :offer_id, index: true
      t.float :offer_price, precision: 8, scale: 2, nil: false
      t.integer :position, nil: false
    end
    add_foreign_key :offers, :products, column: :offer_id, primary_key: :id
  end
end
