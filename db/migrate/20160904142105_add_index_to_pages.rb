class AddIndexToPages < ActiveRecord::Migration[5.0]
  def change
    add_index :pages, :pageable_id
    add_index :pages, :pageable_type
  end
end
