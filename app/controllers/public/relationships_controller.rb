class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  #フォローボタン非同期化
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
		render :follow
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
		render :follow
  end

  #フォローした人の一覧を表示するため
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.order(created_at: :desc).page(params[:page])
  end

  #フォローしてくれた人の一覧を表示するため
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.order(created_at: :desc).page(params[:page])
  end
end