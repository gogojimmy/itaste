class AddProcessAndStoreToImage < ActiveRecord::Migration
  def change
    add_column :photos, :image_processing, :boolean
    add_column :photos, :image_tmp, :string
  end
end
