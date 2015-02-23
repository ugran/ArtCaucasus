class AddItemIdToPricerequests < ActiveRecord::Migration
  def change
    add_column :pricerequests, :item_id, :integer
    add_index :pricerequests, :item_id
  end
end
