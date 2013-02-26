class AddTypeColumnToPages < ActiveRecord::Migration
  def change
    add_column :pages, :type, :string, limit: 20
  end
end
