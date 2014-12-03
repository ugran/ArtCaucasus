class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.text :name
      t.text :description
      t.text :specialization
      t.text :country
      t.text :manager
      t.text :phone_number
      t.text :secondary_phone_number
      t.text :email
      t.text :secondary_email

      t.timestamps
    end
  end
end
