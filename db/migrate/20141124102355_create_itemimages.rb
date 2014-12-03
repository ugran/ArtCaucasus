class CreateItemimages < ActiveRecord::Migration
  def change
    create_table :itemimages do |t|
      t.text :description

      t.timestamps
    end
  end
end
