class AddItemIdToCarousels < ActiveRecord::Migration
  def change
    add_column :carousels, :item_id, :integer
    add_index :carousels, :item_id
  end
end
