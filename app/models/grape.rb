#encoding: utf-8
class Grape < ActiveRecord::Base
  attr_accessible :appearance, :name, :nose, :taste
  has_many :wine_grape_ship
  has_many :wines, through: :wine_grape_ship
  has_many :grape_region_ship
  has_many :regions, through: :grape_region_ship

  def self.tokens(query)
    grapes = where("name like ?", "%#{query}%")
    if grapes.empty?
      [{id: "<<<#{query}>>>", name: "新增: \"#{query}\""}]
    else
      grapes
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
