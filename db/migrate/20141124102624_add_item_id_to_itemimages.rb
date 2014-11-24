class AddItemIdToItemimages < ActiveRecord::Migration
  def change
    add_column :itemimages, :item_id, :integer
    add_index :itemimages, :item_id
  end
end
