class FoodsController < ApplicationController
  def index
    @foods = Food.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @foods.tokens(params[:q]) }
    end
  end
end
