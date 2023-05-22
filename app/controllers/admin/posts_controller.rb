class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    ##サイドバーにソート機能を実装
    #各メソッドはPostモデルに記述
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    elsif params[:star_count]
      @posts = Post.star_count.page(params[:page])
    elsif params[:favorite_count]
      @posts = Post.favorite_count.page(params[:page])
    elsif params[:comment_count]
      @posts = Post.comment_count.page(params[:page])
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to admin_root_path
  end

end
