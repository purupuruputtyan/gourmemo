class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    #active_userはユーザーのステータスが”退会”以外のユーザーを絞り込んだメソッドでモデルに記述している
    #検索ワードに引っかかったユーザーだけ一覧に表示させる
    #search_forメソッドはモデルに記述
    @users = User.active_user.search_for(@content).page(params[:page])

    ##[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    #ユーザーテーブルから”公開”になっているユーザーかカレントユーザーの場合非公開でも表示させたいためカレントユーザーのidを取得し変数に代入
    released_user_ids = User.where(status: :released).or(User.where(id: current_user.id)).pluck(:id)
    #検索ワードに引っかかったレコードのみ一覧に表示させる
    @posts = Post.where(user_id: released_user_ids).search_for(@content).page(params[:page])
  end

end
