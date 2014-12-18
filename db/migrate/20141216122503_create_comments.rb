class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :ccontent
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :item_id
  end
end
