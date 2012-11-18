class Producer < ActiveRecord::Base
  attr_accessible :description, :name, :region_id, :lat, :lon
  belongs_to :region
  has_many :wines
end
