class DropColumnsFromPages < ActiveRecord::Migration

  # TODO deal with single change method
  def up
    remove_columns :pages, :ancestry, :position, :leaf
  end

  def down
    add_column :pages, :ancestry, :string, index: true
    add_column :pages, :position, :integer, nil: false
    add_column :pages, :leaf, :boolean, default: false
  end
end
