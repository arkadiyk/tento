class CheckoutController < ApplicationController
  def show
    cart = Cart.find_cart( session[ :cart_id ] )
    @cart_lines_by_supplier = cart.lines_by_supplier
  end
  
  def payment
    @cart = Cart.find_cart( session[ :cart_id ] )
  end
end
