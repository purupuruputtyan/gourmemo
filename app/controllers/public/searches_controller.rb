class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @content = params[:content]
    #active_userはユーザーのステータスが”退会”以外のユーザーを絞り込んだメソッドでモデルに記述している
    #検索ワードに引っかかったユーザーだけ一覧に表示させる
    #search_forメソッドはモデルに記述
    @users = User.active_user.search_for(@content).page(params[:page])

    #[公開ユーザー]と[非公開だけどカレントユーザーだった場合]の投稿だけ表示されるように絞り込み
    #ユーザーテーブルから”公開”になっているユーザーを探し、そのidをローカル変数に配列で保存
    released_user_ids = User.where(status: :released).pluck(:id)
    #カレントユーザーが”非公開”だった場合も一覧に表示するため、カレントユーザーのidをさっきの配列に入れている
    #if current_userは非ログイン時のエラーを回避するため。非ログイン時このifがないとidが取得できないと怒られる
    released_user_ids.push(current_user.id).uniq! if current_user
    #postテーブルから上２行で絞り込んだユーザーのみ、検索ワードに引っかかったレコードのみ一覧に表示させる
    @posts = Post.where(user_id: released_user_ids).search_for(@content).page(params[:page])
  end

end
