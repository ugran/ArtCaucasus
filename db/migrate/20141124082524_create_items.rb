class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :name
      t.text :description
      t.text :item_type
      t.text :date_of_creation
      t.text :dimensions
      t.text :additional_info
      t.integer :price
      t.integer :discount
      t.integer :quantity

      t.timestamps
    end
  end
end
