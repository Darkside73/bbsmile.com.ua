class AddDefaultValueToOffersPosition < ActiveRecord::Migration
  def up
    change_column :offers, :position, :integer, default: 0
    reversible do
      execute %{update offers set position = 0 where position is null}
    end
  end

  def down
    change_column :offers, :position, :integer, nil: false
  end
end
