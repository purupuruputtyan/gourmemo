class Public::HomesController < ApplicationController

  def top
    #[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    released_user_ids = User.where(status: :released).pluck(:id)
    released_user_ids.push(current_user.id).uniq! if current_user
    @posts = Post.where(user_id: released_user_ids).order(created_at: :desc).page(params[:page])
    #@posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def about
  end

end