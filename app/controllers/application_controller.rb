class ApplicationController < ActionController::Base
  before_action :set_classname

  #トップページとそれ以外のページで背景を変えるため
  def set_classname
    if params[:controller] == 'public/homes' && params[:action] == 'top'
      @classname = 'topbody'
    else
      @classname = 'other'
    end
  end

end
