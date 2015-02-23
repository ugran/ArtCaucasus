class CreatePricerequests < ActiveRecord::Migration
  def change
    create_table :pricerequests do |t|
      t.string :email
      t.integer :status
    end
  end
end
