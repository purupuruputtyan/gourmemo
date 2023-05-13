class ApplicationController < ActionController::Base
  before_action :set_classname

  def set_classname
    if params[:controller] =='public/homes' && params[:action] =='top'
      @classname = 'topbody'
    else
      @classname = 'other'
    end
  end

end
