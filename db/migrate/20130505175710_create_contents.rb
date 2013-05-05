class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :text, nil: false
      t.references :contentable, polymorphic: true
      t.timestamps
    end
  end
end
