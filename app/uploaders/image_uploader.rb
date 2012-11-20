# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :fog
  include CarrierWave::MimeTypes
  process :set_content_type

  #include CarrierWaveDirect::Uploader

  #def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :resize_to_fit => [120, 120]
  end

  version :small do
    process :resize_to_fit => [160, 160]
  end

  version :normal do
    process :resize_to_fit => [200, 200]
  end

  version :large do
    process :resize_to_fit => [390, 390]
  end

  version :xlarge do
    process :resize_to_fit => [612, 612]
  end
end
