class AddTimestampsToOffers < ActiveRecord::Migration
  def change
    change_table :offers do |t|
      t.timestamps
    end
  end
end
