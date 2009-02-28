class CustomerOrdersController < ApplicationController
  def show
  end

  def index
    if params[:p1]
      render :action => "show"
    end
    
    @orders = user_orders
  end

end
