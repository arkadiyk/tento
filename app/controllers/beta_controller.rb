class BetaController < ApplicationController
  skip_before_filter :ajax_only
  before_filter :authenticate
  
  def order_list
    supplier_id = params[:id] || 1
    @orders = Order.confirmed_by_supplier(supplier_id)
  end
  
  
  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        @user = username
        username == "tento" && Digest::SHA1.hexdigest(password) == "74370d043a43b32086d3a0d828e409a9f5772436"
      end
    end

end
