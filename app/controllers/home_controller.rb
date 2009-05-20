class HomeController < ApplicationController
  skip_before_filter :ajax_only
 
  def home
  end

  def set_lng
    session[:locale] = params[:id] 
    I18n.locale = session[:locale]
    current_user.update_attribute(:default_locale, I18n.locale) if current_user
    render :js => 'window.location.reload()'
  end
end
