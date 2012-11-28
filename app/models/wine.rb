#encoding: utf-8
class Wine < ActiveRecord::Base
  attr_accessible :alcohol, :appearance, :name, :nose, :price, :producer_id, :serving_temperature_from, :serving_temperature_to, :suggested_glass, :taste, :vintage, :when, :wine_type, :user_id, :place_id, :opinion, :producer_name, :food_ids, :food_tokens, :grape_tokens, :rating, :region_name, :region_id, :complete, :place_name
  attr_reader :food_tokens, :grape_tokens
  include ActiveModel::Dirty

  include Rails.application.routes.url_helpers

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

  validates_presence_of :name
  validates_presence_of :wine_type
  validates_inclusion_of :rating, in: 1..100
  after_save :complete_and_post_to_fb

  scope :uncomplete, where(complete: false)
  scope :completed, where(complete: true)

  WINE_TYPE = %w{ red_wine white_wine champagne sparkling_wine }
  GLASS_TYPE = %w{ bordeaux_red_wine burgundy_red_wine bordeaux_white_wine burgundy_white_wine sparkling_wine dessert_wine }

  def self.find_uncomplete_or_create_without_validation(user)
    wine = user.wines.uncomplete.first || self.create_without_validation(user)
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

  def complete_and_post_to_fb
    if self.complete_changed?
      #self.user.post_to_facebook(wine_url(self))
    end
  end

  private

  def self.create_without_validation(user)
    wine = user.wines.build
    wine.save(validate: false)
    wine
  end

end
