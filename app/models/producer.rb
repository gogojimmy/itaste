class Producer < ActiveRecord::Base
  attr_accessible :description, :name, :lat, :lon
  has_many :wines
end
