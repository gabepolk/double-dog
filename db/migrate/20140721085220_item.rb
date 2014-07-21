class Item < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
    end
  end
end
