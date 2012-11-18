class CreateWineFoodShip < ActiveRecord::Migration
  def change
    create_table :wine_food_ships do |t|
      t.integer :wine_id
      t.integer :food_id

      t.timestamps
    end
    add_index :wine_food_ships, :wine_id
    add_index :wine_food_ships, :food_id
  end
end
