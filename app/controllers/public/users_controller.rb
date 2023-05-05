class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to  user_path(@user.id)
      flash[:notice] = "編集が成功しました"
    else
      render :edit
    end
  end

  def confirm_deleted
    
  end
  
  def is_deleted
  end
  
  def my_page
  end
  
private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :status)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end