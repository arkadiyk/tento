class BetaController < ApplicationController
  skip_before_filter :ajax_only

  def order_list
    supplier_id = params[:id] || 1
    @orders = Order.confirmed_by_supplier(supplier_id)
  end

end
