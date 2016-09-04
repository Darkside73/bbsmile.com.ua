class AddIndexToVariants < ActiveRecord::Migration[5.0]
  def change
    add_index :variants, [:available, :price]
  end
end
