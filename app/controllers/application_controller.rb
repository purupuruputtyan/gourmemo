class ApplicationController < ActionController::Base
  before_action :set_classname

  #トップページとそれ以外のページで背景を変えるため
  def set_classname
    if params[:controller] == 'public/homes' && params[:action] == 'top'
      @classname = 'top-body'
    else
      @classname = 'top-except'
    end
  end

end
