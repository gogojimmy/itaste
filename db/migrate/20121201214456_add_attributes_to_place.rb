class AddAttributesToPlace < ActiveRecord::Migration
  def change
    add_column :places, :facebook_id, :integer
    add_index :places, :facebook_id
  end
end
