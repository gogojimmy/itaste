class Grape < ActiveRecord::Base
  attr_accessible :appearance, :name, :nose, :taste
  has_many :wine_grape_ships
  has_many :wines, through: :wine_grape_ships
  has_many :grape_region_ships
  has_many :regions, through: :grape_region_ships
end
