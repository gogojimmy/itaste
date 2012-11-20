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
    process :resize_to_fill => [120, 120]
    process :quality => 100
  end

  version :small do
    process :resize_to_fill => [160, 160]
    process :quality => 100
  end

  version :normal do
    process :resize_to_fill => [200, 200]
    process :quality => 100
  end

  version :large do
    process :resize_to_fill => [390, 390]
    process :quality => 100
  end

  version :xlarge do
    process :resize_to_fill => [612, 612]
    process :quality => 100
  end
end
