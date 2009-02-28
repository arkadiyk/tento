class CheckoutController < ApplicationController
  def show
    @cart = current_cart
  end
  
  def payment
    @cart = current_cart
  end
  
  def pay
    @cart = current_cart
    @cart.confirmed_at = Time.now
    @cart.pay_method = params[:payment_method]
    @cart.save!
  end

  def new_address
    @address = current_cart.ship_to
  end

  def create_address
    @address = Address.new(params[:address])
    @address.save!
    current_cart.ship_to = @address
    current_cart.save!
    
    if params[:default_addr]
      current_user.shipping_addr = @address
      current_user.save!
    end
    
    render :js => "boxReload('checkout_box')"
  end

end
