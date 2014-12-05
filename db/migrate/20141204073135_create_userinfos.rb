class CreateUserinfos < ActiveRecord::Migration
  def change
    create_table :userinfos do |t|
      t.string :firstname
      t.string :lastname
      t.string :country
      t.text :address
      t.string :phone
      t.string :zipcode
      t.integer :user_id

      t.timestamps
    end
    add_index :userinfos, :user_id
  end
end
