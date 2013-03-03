class AddPositionColumnToPages < ActiveRecord::Migration
  def change
    add_column :pages, :position, :integer, nil: false, default: 0
  end
end
