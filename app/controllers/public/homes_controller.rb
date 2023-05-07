class Public::HomesController < ApplicationController

  def top
    @posts = Post.joins(:user).where(users: {status: User.statuses[:released]}).or(Post.joins(:user).where(user_id: current_user.id)).order(created_at: :desc) .page(params[:page])
  end

  def about
  end

end