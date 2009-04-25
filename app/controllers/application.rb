# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8845df961e294bb31b9082d5552c6ec7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  before_filter :ajax_only
  before_filter :set_locale 
  
  
  def current_cart
    if session[:cart_id]
      begin
        @current_cart ||= Cart.find(session[:cart_id])
      rescue
        session[:cart_id] = nil
      end
      session[:cart_id] = nil if @current_cart && @current_cart.confirmed?
    end

    if session[:cart_id].nil?
      if logged_in?
        @current_cart = Cart.create!(:user => current_user, :ship_to => current_user.shipping_addr)
      else
        @current_cart = Cart.create!
      end
      session[:cart_id] = @current_cart.id
    else
      if logged_in? && @current_cart.user != current_user
        @current_cart.user = current_user
        @current_cart.ship_to = current_user.shipping_addr
        @current_cart.save!
      end
    end
    
    @current_cart
  end

  def update_cart_from_current_user
    cart = current_cart
    if logged_in?
      cart.user = current_user
      cart.ship_to = current_user.shipping_addr
    else
      cart.user = nil
      cart.ship_to = nil
    end
    cart.save!
  end
  
  def user_orders
    Cart.customer_orders(current_user)
  end

  
  protected 
    def set_locale 
      I18n.locale = session[:locale] || I18n.default_locale 
    end 
 
  private
    def ajax_only
      if !request.xhr?
        redirect_to('/')
      end
    end

end
