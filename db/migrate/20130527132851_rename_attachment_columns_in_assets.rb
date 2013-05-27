class RenameAttachmentColumnsInAssets < ActiveRecord::Migration
  def change
    remove_attachment :assets, :asset
    add_attachment :assets, :attachment
  end
end
