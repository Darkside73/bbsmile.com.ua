class AddVideoToProducts < ActiveRecord::Migration
  def change
    add_column :products, :video, :string
  end
end
