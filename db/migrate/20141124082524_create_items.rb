class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :item_type
      t.string :item_tag
      t.string :date_of_creation
      t.string :height
      t.string :width
      t.string :width2
      t.string :shape
      t.text :additional_info
      t.integer :sold_out, default: 0, null: false
      t.integer :price
      t.integer :discount, default: 0, null: false
      t.integer :quantity

      t.timestamps
    end
  end
end
