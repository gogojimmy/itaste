# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :resize_to_limit => [160, 160]
  end

  version :normal do
    process :resize_to_limit => [200, 200]
  end

  version :large do
    process :resize_to_limit => [390, 390]
  end

  version :xlarge do
    process :resize_to_limit => [612, 612]
  end
end
