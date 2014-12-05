class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.text :description
      t.string :specialization
      t.string :country
      t.string :manager
      t.string :phone_number
      t.string :secondary_phone_number
      t.string :email
      t.string :secondary_email

      t.timestamps
    end
  end
end
