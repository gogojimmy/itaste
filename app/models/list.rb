class List < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :wind_ids
  belongs_to :user
  has_many :wine_list_ship
  has_many :wines, through: :wine_list_ship
end
