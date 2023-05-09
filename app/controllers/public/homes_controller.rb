class Public::HomesController < ApplicationController

  def top
    #to = Time.current.at_end_of_day
    #from = (to - 6.day).at_beginning_of_day
    #[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    released_user_ids = User.where(status: :released).pluck(:id)
    released_user_ids.push(current_user.id).uniq! if current_user
    @posts = Post.week_favorites.where(user_id: released_user_ids).
      joins(:favorites).group('favorites.post_id').order('count(favorites.post_id) DESC').page(params[:page])
    #joinでfavoriteテーブルを結合し、groupでfavoriteテーブルのpost_idだけを読み取り、order内でpost_idをカウントしている。
  end

  def about
  end

end