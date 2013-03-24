class CreateCategories < ActiveRecord::Migration

  # TODO use reversible method
  def up
    create_table :categories do |t|
      t.string :ancestry, index: true
      t.integer :position, nil: false
      t.boolean :leaf, default: false
      t.timestamps
    end

    Page.where(type: 'Category').each do |category|
      ancestry = category.ancestry.nil? ? "null" : "'#{category.ancestry}'"
      execute <<-SQL
        INSERT INTO categories (id, ancestry, position, leaf, created_at, updated_at)
        VALUES (
          #{category.id}, #{ancestry}, #{category.position}, #{category.leaf},
          '#{category.created_at}', '#{category.updated_at}'
        )
      SQL
    end
  end

  def down
    drop_table :categories
  end
end
