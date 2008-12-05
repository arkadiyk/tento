class CheckoutController < ApplicationController
  helper do
    def id_prefix
      logger.debug ""
      "co_"
    end
    def show_points
      true
    end
  end

  def show
    cart = Cart.find_cart( session[ :cart_id ] )
    @cart_lines_by_supplier = cart.lines_by_supplier
  end

end
