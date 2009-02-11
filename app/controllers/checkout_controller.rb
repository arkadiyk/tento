class CheckoutController < ApplicationController
  def show
    @cart = current_cart
  end
  
  def payment
    @cart = current_cart
  end
  
  def new_address
  end

  def create_address
    render :js => "boxReload('checkout_box')"
  end

end
