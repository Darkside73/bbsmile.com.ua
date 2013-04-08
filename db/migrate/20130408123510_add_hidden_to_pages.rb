class AddHiddenToPages < ActiveRecord::Migration
  def change
    add_column :pages, :hidden, :boolean, default: false
  end
end
