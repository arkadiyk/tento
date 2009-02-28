class CustomerOrdersController < ApplicationController
  def show    
  end

  def index
    @orders = user_orders
    if params[:p1]
      @corder = Cart.find_by_order_id current_user, params[:p1]
      if @corder
        idx = @orders.index(@corder)
        if idx > 0
          @prev = @orders[idx - 1].order_id
        end
        if idx < @orders.length - 1
          @next = @orders[idx + 1].order_id
        end
      end
      render :action => "show"
    end
  end

end
