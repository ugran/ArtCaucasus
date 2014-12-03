class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.text :description
      t.text :additional_info
      t.integer :item_price
      t.integer :shipping_cost



      t.timestamps
    end
  end
end
