# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  #deviseやブラウザの仕様でroot_pathに遷移しないことがあるため、あえて記述
  def after_sign_in_path_for(resource)
    root_path
  end

  #ゲストユーザーログイン用アクション
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'guestuserでログインしました。'
  end

protected

  #在籍状況ステータスが"退会"
  def user_state
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.withdraw?)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to root_path
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
