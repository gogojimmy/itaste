#encoding: utf-8
class WinesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    @wine = Wine.find(params[:id])
  end

  def index
    if params[:format] == 'json'
      @wines = Wine.completed.order(:name).where("name like ?", "%#{params[:term]}%")
    else
      @wines = Wine.completed.paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.json { render :json => @wines.map(&:name) }
    end
  end

  def notes
    @user = User.find(params[:user_id])
    @wines = @user.wines.completed.paginate(page: params[:page], per_page: 20)
  end

  def create_wine
    @wine = Wine.find_uncomplete_or_create_without_validation(current_user)
    redirect_to edit_wine_path(@wine)
  end

  #def new
    #@wine = current_user.wines.build
  #end

  #def create
    #@wine = current_user.wines.build(params[:wine])
    #if @wine.save
      #redirect_to @wine, notice: "成功建立一則筆記"
    #else
      #render :new
    #end
  #end

  def edit
    @wine = Wine.find(params[:id])
    redirect_to @wine, notice: '你沒有權限編輯這個項目' unless current_user.has_permission?(@wine)
  end

  def update
    @wine = Wine.find(params[:id])
    redirect_to @wine, notice: '你沒有權限編輯這個項目' unless current_user.has_permission?(@wine)

    if @wine.update_attributes(params[:wine])
      redirect_to @wine, notice: "成功更新了#{@wine.name}"
    else
      render :edit
    end
  end

  def destroy
    @wine = Wine.find(params[:id])
    redirect_to @wine, notice: '你沒有權限編輯這個項目' unless current_user.has_permission?(@wine)

    name = @wine.name
    @wine.destroy
    redirect_to user_notes_path(current_user), notice: "成功刪除了#{name}"
  end
end
