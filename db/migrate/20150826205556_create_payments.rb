class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :order, index: true, foreign_key: true
      t.float :amount, precision: 8, scale: 2
      t.string :transaction_uid
      t.string :account
      t.string :status

      t.timestamps null: false
    end
  end
end
