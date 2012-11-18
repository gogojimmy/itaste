class PhotosController < ApplicationController
  def create
    @photo = Photo.create(params[:photo])
  end
end
