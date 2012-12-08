#encoding: utf-8
class Wine < ActiveRecord::Base
  attr_accessible :alcohol, :appearance, :name, :nose, :price, :producer_id, :serving_temperature_from, :serving_temperature_to, :suggested_glass, :taste, :vintage, :when, :wine_type, :user_id, :place_id, :opinion, :producer_name, :food_ids, :food_tokens, :grape_tokens, :rating, :region_name, :region_id, :complete, :place_name, :place_attributes
  attr_reader :food_tokens, :grape_tokens
  include ActiveModel::Dirty

  is_impressionable counter_cache: true

  belongs_to :user
  belongs_to :producer
  belongs_to :region
  belongs_to :place
  has_many :wine_grape_ship
  has_many :grapes, through: :wine_grape_ship
  has_many :wine_badge_ship
  has_many :badges, through: :wine_badge_ship
  has_many :wine_food_ship
  has_many :foods, through: :wine_food_ship
  has_many :photos
  has_many :wine_list_ship
  has_many :lists, through: :wine_list_ship
  accepts_nested_attributes_for :place

  validates_presence_of :name
  validates_presence_of :wine_type
  validates_inclusion_of :rating, in: 1..100

  scope :uncomplete, where(complete: false)
  scope :completed, where(complete: true)
  scope :sitemap, :select => 'id, name, created_at, updated_at', :limit => 4999

  before_update :find_or_create_place

  delegate :facebook_id, to: :place, allow_nil: true, prefix: true

  WINE_TYPE = %w{ red_wine white_wine champagne sparkling_wine }
  GLASS_TYPE = %w{ bordeaux_red_wine burgundy_red_wine bordeaux_white_wine burgundy_white_wine sparkling_wine dessert_wine }

  def self.find_uncomplete_or_create_without_validation(user)
    wine = user.wines.uncomplete.first || self.create_without_validation(user)
  end

  def other_wines(count=4)
    ids = self.user.wines.map(&:id)
    ids.delete self.id
    Wine.find(ids).sample(count)
  end

  def serving_temperature_range
    serving_temperature_from.to_s + "度 - " + serving_temperature_to.to_s + "度"
  end

  def producer_name
    producer.try(:name)
  end

  def producer_name=(name)
    self.producer = Producer.find_or_create_by_name(name) if name.present?
  end

  def place_name
    place.try(:name)
  end

  def place_name=(name)
    self.place = Place.find_or_create_by_name(name) if name.present?
  end

  def region_name
    region.try(:name)
  end

  def region_name=(name)
    self.region = Region.find_or_create_by_name(name) if name.present?
  end

  def food_tokens=(tokens)
    self.food_ids = Food.ids_from_tokens(tokens)
  end

  def grape_tokens=(tokens)
    self.grape_ids = Grape.ids_from_tokens(tokens)
  end

  private

  def self.create_without_validation(user)
    wine = user.wines.build
    wine.save(validate: false)
    wine
  end

  def find_or_create_place
    self.place = Place.where(facebook_id: self.place.facebook_id).first_or_create do |p|
      p.name = self.place.name
      p.lat = self.place.lat
      p.lon = self.place.lon
    end
  end

end
