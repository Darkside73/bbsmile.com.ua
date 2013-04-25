class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :asset
      t.timestamps
    end
  end
end
