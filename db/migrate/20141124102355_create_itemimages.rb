class CreateItemimages < ActiveRecord::Migration
  def change
    create_table :itemimages do |t|
      t.string :description

      t.timestamps
    end
  end
end
