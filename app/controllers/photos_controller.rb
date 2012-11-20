class PhotosController < ApplicationController
  def create
    @photo = Photo.create(params[:photo])
  end

  def set_feature
    @photo = Photo.find(params[:photo_id])
    @last_feature_photo = @photo.wine.photos.where(is_feature: true).first
    @photo.set_as_feature
  end

  def destroy
    @photo = Photo.find(params[:id])
    @id = @photo.id
    @photo.destroy
  end
end
