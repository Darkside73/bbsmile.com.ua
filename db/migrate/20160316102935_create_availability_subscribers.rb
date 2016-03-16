class CreateAvailabilitySubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :availability_subscribers do |t|
      t.references :variant, foreign_key: true
      t.string :email
      t.string :phone
      t.index [:variant_id, :email], unique: true
      t.index [:variant_id, :phone], unique: true
    end
  end
end
