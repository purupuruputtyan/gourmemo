class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  #コメント削除非同期化
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

end
