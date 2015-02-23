class AddUserIdToPricerequests < ActiveRecord::Migration
  def change
    add_column :pricerequests, :user_id, :integer
    add_index :pricerequests, :user_id
  end
end
