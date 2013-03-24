class AddPolymorphicReferencesToPages < ActiveRecord::Migration
  def up
    change_table :pages do |t|
      t.references :pageable, polymorphic: true
    end
    execute <<-SQL
      UPDATE pages SET pageable_id = id, pageable_type = 'Category'
      WHERE type = 'Category'
    SQL
    remove_column :pages, :type
  end

  def down
    remove_columns :pages, :pageable_id, :pageable_type
    add_column :pages, :type, :string
  end
end
