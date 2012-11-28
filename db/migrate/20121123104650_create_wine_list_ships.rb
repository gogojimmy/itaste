class CreateWineListShips < ActiveRecord::Migration
  def change
    create_table :wine_list_ships do |t|
      t.integer :wine_id
      t.integer :list_id

      t.timestamps
    end
    add_index :wine_list_ships, :wine_id
    add_index :wine_list_ships, :list_id
  end
end
