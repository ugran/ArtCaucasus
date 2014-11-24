class AddArtistIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :artist_id, :integer
    add_index :items, :artist_id
  end
end
