class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :headline
      t.text :description
    end
  end
end
