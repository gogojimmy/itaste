class CreateWineBadgeShip < ActiveRecord::Migration
  def change
    create_table :wine_badge_ships do |t|
      t.integer :wine_id
      t.integer :badge_id

      t.timestamps
    end
    add_index :wine_badge_ships, :wine_id
    add_index :wine_badge_ships, :badge_id
  end
end
