class Admin::UsersController < ApplicationController
  #before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
      flash[:notice] = "編集に成功しました"
    else
      render :edit
    end
  end

  def is_deleted
    @user = current_user
    @user.update(status: 2)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_users_path
  end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :status)
  end

end
