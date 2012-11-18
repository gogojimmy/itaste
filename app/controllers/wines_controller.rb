#encoding: utf-8
class WinesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @wine = Wine.find(params[:id])
  end

  def index
    if params[:user_id]
      @wines = @user.wines.paginate(page: params[:page])
    else
      @wines = Wine.paginate(page: params[:page])
    end
  end

  def new
    @wine = current_user.wines.build
  end

  def create
    @wine = current_user.wines.build(params[:wine])
    if @wine.save
      redirect_to @wine, notice: "成功建立一則筆記"
    else
      render :new
    end
  end

  def edit
    @wine = Wine.find(params[:id])
  end

  def update
    @wine = Wine.find(params[:id])
    if @wine.update_attributes(params[:wine])
      redirect_to @wine, notice: "成功更新了#{@wine.name}"
    else
      render :edit
    end
  end

  def destroy
    @wine = Wine.find(params[:id])
    name = @wine.name
    @wine.destroy
    redirect_to user_wines_path(current_user), notice: "成功刪除了#{name}"
  end
end
