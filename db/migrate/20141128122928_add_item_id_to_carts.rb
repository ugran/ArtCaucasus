class AddItemIdToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :item_id, :integer
    add_index :carts, :item_id
  end
end
