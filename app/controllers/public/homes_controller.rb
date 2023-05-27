class Public::HomesController < ApplicationController
  before_action :admin_exists?, only: [:top]

  ###投稿一覧と似ているが、トップページはヒーローエリアにしている
  ##[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
  def top
    #ユーザーテーブルから”公開”になっているユーザーかカレントユーザーの場合非公開でも表示させたいためカレントユーザーのidを取得し変数に代入
    #「&」はSafe Navigation Operatorという演算子でcurrent_user が nil である場合に、nil を返し、current_user が存在する場合には current_user.id を返す。
    #「&」はif current_user endで囲っているのと同じ役割を果たしてくれている。
    released_user_ids = User.where(status: :released).or(User.where(id: current_user&.id)).pluck(:id)

    # Postの公開されている記事を取得する。
    @posts = Post.where(user_id: released_user_ids)

    # その中から１週間のうちに投稿されたデータがあればそのデータのみ取得する。
    if @posts.week_posts.present?
      @posts = @posts.week_posts
    end

    # その中からいいねがついているデータを取得する。
    @posts = @posts.eager_load(:favorites).group('posts.id').order('count(favorites.post_id) DESC')

    @posts = @posts.page(params[:page])
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