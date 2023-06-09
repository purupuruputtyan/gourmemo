class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.active_user.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to  my_page_path
      flash[:notice] = "編集に成功しました。"
    else
      #26,27行目は、必須箇所をブランクにするなど編集に失敗した時に元の画像表示を消えなくさせるため。
      @user.reload
      @user.assign_attributes(user_params_without_image)
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
    flash[:notice] = "退会処理を実行いたしました。"
    redirect_to root_path
  end

  #マイページにユーザー情報と自分が投稿した一覧を表示
  def my_page
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(6)
  end

private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :status)
  end

  #ユーザーの編集画面で、入力必須がblankになってしまった時にプレビューを表示させるため
  def user_params_without_image
    params.require(:user).permit(:name, :introduction, :status)
  end

  #カレントユーザー以外プロフィール編集画面にアクセスできなくさせる
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert] = "他ユーザーのプロフィール編集画面には遷移できません。"
      redirect_to user_path(current_user.id)
    end
  end

  #カレントユーザーでもゲストユーザーはプロフィール編集画面にアクセスできなくさせる
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      flash[:alert] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end

end