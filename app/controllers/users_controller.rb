class UsersController < ApplicationController
 
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @address = Address.new(params[:address])
    @user.shipping_addr = @address

    success = true
    
    begin
      @user.transaction do
        @user.save!
        @user.shipping_addr.save!
      end
    rescue
      success = false
    end

    if success && @user.errors.empty? && @user.shipping_addr.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in

      update_cart_from_current_user
      @user.update_attribute(:default_locale, I18n.locale)
      
      flash[:notice] = I18n.t(:signup_complete)

      render :template => 'account/show'
      
    else
      flash[:error]  = I18n.t(:signup_problem)
      render :action => 'new'
    end
  end
end
