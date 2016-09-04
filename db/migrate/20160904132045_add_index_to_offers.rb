class AddIndexToOffers < ActiveRecord::Migration[5.0]
  def change
    add_index :offers, :position
  end
end
