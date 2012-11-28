class Place < ActiveRecord::Base
  attr_accessible :lat, :lon, :name
  has_many :wines
end
