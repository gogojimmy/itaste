class Place < ActiveRecord::Base
  attr_accessible :lat, :lon, :name, :facebook_id
  has_many :wines

end
