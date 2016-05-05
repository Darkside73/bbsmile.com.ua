class AddDeletedAtToVariants < ActiveRecord::Migration[5.0]
  def change
    add_column :variants, :deleted_at, :datetime
  end
end
