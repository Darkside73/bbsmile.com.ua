class RemoveTopicalityFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :topicality, :boolean, default: false
  end
end
