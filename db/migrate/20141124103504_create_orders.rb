class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :tracking_number
      t.text :status
      t.text :description
      t.text :additional_info
      t.integer :u_id
      t.integer :item_price
      t.integer :shipping_cost

      t.timestamps
    end
  end
end
