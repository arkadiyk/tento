# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem and localizate in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :localizate
  
  def localizate
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      render :template => 'account/show'
      flash[:notice] = I18n.t(:logged_in)
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    save_cart = session[:cart_id]
    logout_killing_session!
    flash[:notice] = I18n.t(:logged_out)
    session[:cart_id] = save_cart
    render :js => 'window.location.reload()'
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = I18n.t(:login_failed, :login => params[:login])
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
