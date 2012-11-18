class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :foods, :name
  end
end
