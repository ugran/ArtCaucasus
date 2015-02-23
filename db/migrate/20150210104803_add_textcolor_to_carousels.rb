class AddTextcolorToCarousels < ActiveRecord::Migration
  def change
    add_column :carousels, :textcolor, :integer, :default => 0
    add_column :carousels, :placerank, :integer, :default => 0
  end
end
