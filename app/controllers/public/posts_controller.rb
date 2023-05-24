class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  ##[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
  def index
    #ユーザーテーブルから”公開”になっているユーザーかカレントユーザーの場合非公開でも表示させたいためカレントユーザーのidを取得し変数に代入
    if current_user
      released_user_ids = User.where(status: :released).or(User.where(id: current_user.id)).pluck(:id)
    else
      #非ログイン時はカレントユーザーのidを取得できないため公開ユーザーのみ取得
      released_user_ids = User.where(status: :released).pluck(:id)
    end
    
    ##サイドバーにソート機能を実装
    #各メソッドはPostモデルに記述
    if params[:latest]
      @posts = Post.where(user_id: released_user_ids).latest.page(params[:page])
    elsif params[:old]
      @posts = Post.where(user_id: released_user_ids).old.page(params[:page])
    elsif params[:star_count]
      @posts = Post.where(user_id: released_user_ids).star_count.page(params[:page])
    elsif params[:favorite_count]
      @posts = Post.where(user_id: released_user_ids).favorite_count.page(params[:page])
    elsif params[:comment_count]
      @posts = Post.where(user_id: released_user_ids).comment_count.page(params[:page])
    else
      #postテーブルから”released_user_ids”に格納されたユーザーのみ、投稿の新しい順で一覧に表示させる
      @posts = Post.where(user_id: released_user_ids).order(created_at: :desc).page(params[:page])
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to my_page_path
  end

  #過去にいいねした投稿を一覧表示させるため。マイページにてカレントユーザーのみ閲覧可能。
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
      flash[:notice] = "他ユーザーの投稿編集画面には遷移できません。"
      redirect_to post_path(post.id)
    end
  end

end
