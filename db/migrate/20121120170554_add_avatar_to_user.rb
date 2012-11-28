class AddAvatarToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :avatar_tmp, :string
    add_column :users, :avatar_processing, :boolean
  end
end
