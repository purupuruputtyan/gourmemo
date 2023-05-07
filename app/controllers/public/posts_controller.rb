class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def index
    #[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    released_user_ids = User.where(status: :released).pluck(:id)
    released_user_ids.push(current_user.id).uniq! if current_user
    @posts = Post.where(user_id: released_user_ids).order(created_at: :desc).page(params[:page])
    #@posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def favorites
    @favorite_posts = current_user.favorite_posts.includes(:user).order(created_at: :desc).page(params[:page])
  end

private

  def post_params
    params.require(:post).permit(:image, :shop_name, :address, :latitude, :longitude, :menu, :impression, :price, :volume_status, :star)
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end

end
