class AddLeafToPages < ActiveRecord::Migration
  def change
    add_column :pages, :leaf, :boolean, default: false
  end
end
