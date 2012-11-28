class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name
      t.string :wine_type
      t.integer :vintage
      t.integer :user_id
      t.decimal :alcohol, :precision => 6, :scale => 5
      t.integer :producer_id
      t.integer :region_id
      t.integer :serving_temperature_from, default: 15
      t.integer :serving_temperature_to, default: 18
      t.string :suggested_glass
      t.float :price
      t.datetime :when
      t.integer :place_id
      t.text :appearance
      t.text :nose
      t.text :taste
      t.text :opinion
      t.integer :rating, default: 95
      t.boolean :complete, default: false

      t.timestamps
    end
    add_index :wines, :name
    add_index :wines, :wine_type
    add_index :wines, :vintage
    add_index :wines, :producer_id
    add_index :wines, :region_id
    add_index :wines, :place_id
    add_index :wines, :price
    add_index :wines, :user_id
  end
end
