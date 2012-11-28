class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :image
      t.integer :wine_id
      t.boolean :is_feature, default: false

      t.timestamps
    end
    add_index :photos, :name
    add_index :photos, :wine_id
  end
end
