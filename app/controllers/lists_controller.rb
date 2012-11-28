#encoding: utf-8
class ListsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:id])
  end

  def new
    @list = current_user.lists.build
  end

  def create
    @list = current_user.lists.build(params[:list])
    if @list.save
      redirect_to user_list_path(current_user, @list), notice: "#{@list.name}酒單建立成功"
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      redirect_to user_list_path(current_user, @list), notice: "#{@list.name}酒單更新成功"
    else
      render :edit
    end
  end

  def destroy
    @list = current_user.lists.find(params[:id])
    name = @list.name
    @list.destroy
    redirect_to user_lists_path(current_user), notice: "#{name}酒單已被刪除"
  end

end
