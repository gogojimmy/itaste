#encoding: utf-8
class Food < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :wine_food_ship
  has_many :wines, through: :wine_food_ship

  def self.tokens(query)
    foods = where("name like ?", "%#{query}%")
    if foods.empty?
      [{id: "<<<#{query}>>>", name: "新增: \"#{query}\""}]
    else
      foods
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
end
