class CheckoutController < ApplicationController
  def show
    @cart = current_cart
  end
  
  def payment
    @cart = current_cart
  end
end
