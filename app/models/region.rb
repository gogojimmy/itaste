class Region < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :wines
end
