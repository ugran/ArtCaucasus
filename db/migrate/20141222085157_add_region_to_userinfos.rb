class AddRegionToUserinfos < ActiveRecord::Migration
  def change
    add_column :userinfos, :region, :string
    add_column :userinfos, :city, :string
  end
end
