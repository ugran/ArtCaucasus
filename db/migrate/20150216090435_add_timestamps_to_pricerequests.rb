class AddTimestampsToPricerequests < ActiveRecord::Migration
  def self.up
        change_table :pricerequests do |t|
            t.timestamps
        end
    end
    def self.down
        remove_column :pricerequests, :created_at
        remove_column :pricerequests, :updated_at
    end
end
