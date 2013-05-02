class AddPositionToImages < ActiveRecord::Migration
  def change
    add_column :images, :position, :integer, nil: false, default: 0
  end
end
