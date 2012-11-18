class GrapesController < ApplicationController
  def index
    @grapes = Grape.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @grapes.tokens(params[:q]) }
    end
  end
end
