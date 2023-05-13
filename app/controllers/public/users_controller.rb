class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.active_user.page(params[:page])
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
      redirect_to  my_page_path
      flash[:notice] = "編集に成功しました"
    else
      render :edit
    end
  end

  #退会確認画面表示
  def confirm_deleted
    @user = current_user
  end

  #ユーザーの在籍ステータスを”退会"に変える
  def is_deleted
    @user = current_user
    @user.update(status: 2)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  #マイページにユーザー情報と自分が投稿した一覧を表示
  def my_page
    @user = current_user
    @posts = @user.posts.page(params[:page]).per(6)
  end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :status)
  end

  #カレントユーザー以外プロフィール編集画面にアクセスできなくさせる
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  #カレントユーザーでもゲストユーザーはプロフィール編集画面にアクセスできなくさせる
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end

end