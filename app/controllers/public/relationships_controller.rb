class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  #フォローした人の一覧を表示するため
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.order(created_at: :desc).page(params[:page])
  end

  #フォローしてくれた人の一覧を表示するため
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.order(created_at: :desc).page(params[:page])
  end
end