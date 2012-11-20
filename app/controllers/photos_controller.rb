class PhotosController < ApplicationController
  def create
    @photo = Photo.create(params[:photo])
  end

  def set_feature
    @photo = Photo.find(params[:photo_id])
    @photo.set_as_feature
  end
end
