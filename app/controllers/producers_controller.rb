class ProducersController < ApplicationController
  def index
    @producers = Producer.order(:name).where("name like ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @producers.map(&:name) }
    end
  end
end
