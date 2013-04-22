class AddDefaultValueForAvailableInProducts < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.change :available, :boolean, default: true
    end
  end

  def down
    change_table :products do |t|
      t.change :available, :boolean
    end
  end
end
