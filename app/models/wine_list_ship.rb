class WineListShip < ActiveRecord::Base
  attr_accessible :list_id, :wine_id
  belongs_to :list
  belongs_to :wine
end
