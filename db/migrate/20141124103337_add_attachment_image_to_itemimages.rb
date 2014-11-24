class AddAttachmentImageToItemimages < ActiveRecord::Migration
  def self.up
    change_table :itemimages do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :itemimages, :image
  end
end
