class Public::HomesController < ApplicationController
  before_action :admin_exists?, only: [:top]

  ###投稿一覧と似ているが、トップページはヒーローエリアにしている
  ##[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
  def top
    #ユーザーテーブルから”公開”になっているユーザーかカレントユーザーの場合非公開でも表示させたいためカレントユーザーのidを取得し変数に代入
    #「&」はSafe Navigation Operatorという演算子でcurrent_user が nil である場合に、nil を返し、current_user が存在する場合には current_user.id を返す。
    #「&」はif current_user endで囲っているのと同じ役割を果たしてくれている。
    released_user_ids = User.where(status: :released).or(User.where(id: current_user&.id)).pluck(:id)

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