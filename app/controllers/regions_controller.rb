class RegionsController < ApplicationController
  def index
    @regions = Region.order(:name).where("name like ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @regions.map(&:name) }
    end
  end
end
