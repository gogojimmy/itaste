# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include ::CarrierWave::Backgrounder::Delay
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :fog
  include CarrierWave::MimeTypes
  process :set_content_type

  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :fix_exif_rotation
    process :strip
    process :resize_to_fill => [30, 30]
    process :quality => 100
  end

  version :normal do
    process :fix_exif_rotation
    process :strip
    process :resize_to_fill => [110, 110]
    process :quality => 100
  end

  version :large do
    process :fix_exif_rotation
    process :strip
    process :resize_to_fill => [200, 200]
    process :quality => 100
  end

end
