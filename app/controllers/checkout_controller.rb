class CheckoutController < ApplicationController
  def show
    @cart = Cart.find_cart( session[ :cart_id ] )
  end
  
  def payment
    @cart = Cart.find_cart( session[ :cart_id ] )
  end
end
