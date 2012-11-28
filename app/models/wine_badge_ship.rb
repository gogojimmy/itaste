class WineBadgeShip < ActiveRecord::Base
  attr_accessible :badge_id, :wine_id
  belongs_to :wine
  belongs_to :badge
end
