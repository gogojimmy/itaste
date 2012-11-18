class CreateGrapeRegionShip < ActiveRecord::Migration
  def change
    create_table :grape_region_ships do |t|
      t.integer :grape_id
      t.integer :region_id

      t.timestamps
    end
    add_index :grape_region_ships, :grape_id
    add_index :grape_region_ships, :region_id
  end
end
