class Badge < ActiveRecord::Base
  attr_accessible :name
  has_many :wine_badge_ships
  has_many :wines, through: :wine_badge_ships
end
