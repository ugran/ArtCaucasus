class CreateUserinfos < ActiveRecord::Migration
  def change
    create_table :userinfos do |t|
      t.text :firstname
      t.text :lastname
      t.text :country
      t.text :address
      t.text :phone
      t.text :zipcode
      t.integer :user_id

      t.timestamps
    end
    add_index :userinfos, :user_id
  end
end
