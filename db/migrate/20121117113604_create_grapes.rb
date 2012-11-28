class CreateGrapes < ActiveRecord::Migration
  def change
    create_table :grapes do |t|
      t.string :name
      t.text :taste
      t.text :nose
      t.text :appearance

      t.timestamps
    end
  end
end
