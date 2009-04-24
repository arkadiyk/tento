class HomeController < ApplicationController
  skip_before_filter :ajax_only
 
  def home
  end

  def set_lng
    session[:locale] = params[:id] 
    I18n.locale = session[:locale]

      logger.error "============================"
      logger.error I18n.locale
      logger.error session[:locale]
      logger.error "============================"
      
    render :js => 'window.location.reload()'
  end
end
