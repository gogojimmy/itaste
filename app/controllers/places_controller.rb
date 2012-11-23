class PlacesController < ApplicationController
  def index
    @places = Place.order(:name).where("name like ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @places.map(&:name) }
    end
  end
end
