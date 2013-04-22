class AddPositionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :position, :integer, nil: false, default: 0
  end
end
