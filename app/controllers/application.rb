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
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
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
  end

  
  private
    def ajax_only
      if !request.xhr?
        redirect_to('/')
      end
    end
end
