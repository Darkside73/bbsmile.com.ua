class RemoveOffersPositionDefaultValue < ActiveRecord::Migration
  def up
      change_column :offers, :position, :integer, nil: false
      reversible do
        execute %{update offers set position = 1 where position = 0}
      end
    end

    def down
      change_column :offers, :position, :integer, default: 0
    end
end
