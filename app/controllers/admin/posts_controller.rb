class Admin::PostsController < ApplicationController
  #before_action :authenticate_admin!

  def index
    @posts = Post.all.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

end
