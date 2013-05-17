class AddNameToPages < ActiveRecord::Migration
  def change
    add_column :pages, :name, :string
  end
end
