class AddArtistNameToItems < ActiveRecord::Migration
  def change
    add_column :items, :artist_name, :string
  end
end
