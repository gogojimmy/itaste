class Photo < ActiveRecord::Base
  attr_accessible :name, :wine_id, :image, :remote_image_url
  belongs_to :wine
  mount_uploader :image, ImageUploader

  def self.feature_photo(version = :normal)
    photo = where(is_feature: true).first || self.first
    photo.image_url(version)
  end
end
