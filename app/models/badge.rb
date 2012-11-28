class Badge < ActiveRecord::Base
  attr_accessible :name
  has_many :wine_badge_ship
  has_many :wines, through: :wine_badge_ship
end
