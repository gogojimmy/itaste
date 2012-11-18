#encoding: utf-8
class Wine < ActiveRecord::Base
  attr_accessible :alcohol, :appearance, :name, :nose, :price, :producer_id, :region_id, :serving_temperature_from, :serving_temperature_to, :suggested_glass, :taste, :vintage, :when, :wine_type, :user_id, :place_id, :opinion, :producer_name

  belongs_to :user
  belongs_to :producer
  belongs_to :region
  belongs_to :place
  has_many :wine_grape_ships
  has_many :grapes, through: :wine_grape_ships
  has_many :wine_badge_ships
  has_many :badges, through: :wine_badge_ships

  validates_presence_of :name
  validates_presence_of :wine_type

  WINE_TYPE = %w{ red_wine white_wine champagne sparkling_wine }
  GLASS_TYPE = %w{ bordeaux_red_wine burgundy_red_wine bordeaux_white_wine burgundy_white_wine sparkling_wine dessert_wine }

  def serving_temperature_range
    serving_temperature_from.to_s + "度 - " + serving_temperature_to.to_s + "度"
  end

  def producer_name
    producer.try(:name)
  end

  def producer_name=(name)
    self.producer = Producer.find_or_create_by_name(name) if name.present?
  end
end
