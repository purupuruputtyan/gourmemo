class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @users = User.active_user.search_for(@content, @method).page(params[:page])
    elsif @model == 'post'
    #ユーザーステータスが”公開”と、カレントユーザーであれば”非公開”の場合一覧に表示する
      released_user_ids = User.where(status: :released).pluck(:id)
      released_user_ids.push(current_user.id).uniq! if current_user
      @posts= Post.where(user_id: released_user_ids).search_for(@content, @method).page(params[:page])
    #elsif @model == 'tag'
	  #	@records = Tag.search_books_for(@content, @method)
	  #else
	  #  @users = User.active_user.search_for(@content, @method).page(params[:page])
	  # @posts= Post.where(user_id: released_user_ids).search_for(@content, @method).page(params[:page])
    end
  end

end
