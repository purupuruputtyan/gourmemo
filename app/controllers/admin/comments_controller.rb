class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  #コメント削除機能非同期化
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

end
