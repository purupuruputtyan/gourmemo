class Public::HomesController < ApplicationController

  def top
    #to = Time.current.at_end_of_day
    #from = (to - 6.day).at_beginning_of_day
    #[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    released_user_ids = User.where(status: :released).pluck(:id)
    released_user_ids.push(current_user.id).uniq! if current_user
    @posts = Post.where(user_id: released_user_ids).order(created_at: :desc).page(params[:page])
    #@posts = Post.where(user_id: released_user_ids).includes(:favorited_users).
    #  sort_by {|x|
    #    x.favorited_users.includes(:favorites).where(created_at: from...to).size
    #  }.reverse.page(params[:page])
    #@posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def about
  end

end