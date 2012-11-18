class CreateWineGrapeShips < ActiveRecord::Migration
  def change
    create_table :wine_grape_ships do |t|
      t.integer :wine_id
      t.integer :grape_id

      t.timestamps
    end
    add_index :wine_grape_ships, :wine_id
    add_index :wine_grape_ships, :grape_id
  end
end
