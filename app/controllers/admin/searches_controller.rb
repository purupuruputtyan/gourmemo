class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method).page(params[:page])
    elsif @model == 'post'
      @records = Post.search_for(@content, @method).page(params[:page])
    #elsif @model == 'tag'
		#	@records = Tag.search_books_for(@content, @method)
    end
  end

end
