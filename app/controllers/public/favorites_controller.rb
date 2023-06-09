class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  #いいね機能（作成、削除）非同期化
  def create
    @post = Post.find(params[:post_id])
    current_user.favorites.find_or_create_by(post_id: @post.id)
    render :favorite
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy if favorite
    render :favorite
  end
end