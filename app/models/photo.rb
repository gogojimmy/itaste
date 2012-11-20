class Photo < ActiveRecord::Base
  attr_accessible :name, :wine_id, :image, :remote_image_url
  belongs_to :wine
  mount_uploader :image, ImageUploader

  def self.feature_photo(version = :normal)
    photo = where(is_feature: true).first || self.first
    photo.image_url(version)
  end

  def set_as_feature
    self.set_as_feature_and_unset_others
  end

  def set_as_feature_and_unset_others
    self.wine.photos.update_all(is_feature: false)
    self.update_attribute(:is_feature, true)
  end
end
