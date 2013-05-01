class AddPolymorphicToImages < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.references :imageable, polymorphic: true
    end
  end
end
