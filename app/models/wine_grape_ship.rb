class WineGrapeShip < ActiveRecord::Base
  attr_accessible :grape_id, :wine_id
  belongs_to :wine
  belongs_to :grape
end
