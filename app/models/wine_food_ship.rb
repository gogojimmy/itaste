class WineFoodShip < ActiveRecord::Base
  attr_accessible :food_id, :wine_id
  belongs_to :wine
  belongs_to :food
end
