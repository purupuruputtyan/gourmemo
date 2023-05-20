class Public::HomesController < ApplicationController
  before_action :admin_exists?, only: [:top]

  #投稿一覧と似ているが、トップページはヒーローエリアにしている
  def top
    #[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    #ユーザーテーブルから”公開”になっているユーザーを探し、そのidをローカル変数に配列で保存
    released_user_ids = User.where(status: :released).pluck(:id)
    #カレントユーザーが”非公開”だった場合も一覧に表示するため、カレントユーザーのidをさっきの配列に入れている
    #if current_userは非ログイン時のエラーを回避するため。非ログイン時このifがないとidが取得できないと怒られる
    released_user_ids.push(current_user.id).uniq! if current_user
    #postモデルにweek_postsメソッドを記述。この過去１週間の作成日時を抽出している。
    #postテーブルから過去１週間の作成日時を抽出し、さらにそこからアクティブなユーザーだけを探している
    @posts = Post.week_posts.where(user_id: released_user_ids).
      #eager_loadでfavoriteテーブルを外部結合し、groupでpostのidを基準にして、、order内でfavoriteテーブルのpost_idをカウントしている
      eager_load(:favorites).group('posts.id').order('count(favorites.post_id) DESC').page(params[:page])
  end

  def about
  end

private
  #管理者がログインしているときに、ユーザーのrootパスに行けてしまうを防ぐため
  def admin_exists?
    if admin_signed_in?
      redirect_to admin_root_path
    end
  end

end