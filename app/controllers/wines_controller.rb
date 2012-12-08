#encoding: utf-8
class WinesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :notes]
  load_and_authorize_resource except: [:notes, :create_wine, :facebook_places]

  def show
    @wine = Wine.find(params[:id])
  end

  def index
    if params[:format] == 'json'
      @wines = @wines.completed.order(:name).where("name like ?", "%#{params[:term]}%")
    else
      @wines = @wines.completed.order('created_at desc').paginate(page: params[:page])
    end
    respond_to do |format|
      format.html
      format.json { render :json => @wines.map(&:name) }
    end
  end

  def notes
    @user = User.find(params[:user_id])
    @wines = @user.wines.completed.paginate(page: params[:page], per_page: 20)
    @lists = @user.lists
  end

  def create_wine
    @wine = Wine.find_uncomplete_or_create_without_validation(current_user)
    redirect_to edit_wine_path(@wine)
  end

  def edit
    @wine = Wine.find(params[:id])
    @wine.place ||= @wine.build_place
    redirect_to @wine, notice: '你沒有權限編輯這個項目' unless current_user.has_permission?(@wine)
  end

  def update
    @wine = Wine.find(params[:id])
    redirect_to @wine, notice: '你沒有權限編輯這個項目' unless current_user.has_permission?(@wine)

    if @wine.complete?
      if @wine.update_attributes(params[:wine])
        redirect_to @wine, notice: "成功更新了#{@wine.name}"
      else
        render :edit
      end
    else
      if @wine.update_attributes(params[:wine])
        current_user.delay.post_to_facebook(wine_url(@wine), @wine.place_facebook_id)
        redirect_to @wine, notice: "成功建立了#{@wine.name}"
      else
        render :edit
      end
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
