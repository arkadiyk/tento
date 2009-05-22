class AlphaController < ApplicationController
  skip_before_filter :ajax_only
  before_filter :authenticate, :except => :pp 

  def pp
  end

  def index
    @open_carts = Cart.confirmed
  end
  
  def payments
    @cart = Cart.find params[:id]
    if(params[:commit] == 'Add')
      @new_payment = Payment.new(params[:new_payment])
      @new_payment.cart = @cart
      if (@new_payment.save)
        mark_cart_as_paid(@cart)
      end
    elsif(params[:commit] == 'Update')
      @payment = Payment.find(params[:upd_line])
      attrs = params[:payment]["#{@payment.id}"]
      @payment.update_attributes(:comments => attrs[:comments])
    end
  end
  
  def shipments
    @cart = Cart.find params[:id]
    @new_shipment = Shipment.new(:complete => true)
    if(params[:commit] == 'Add')
      @new_shipment = Shipment.new(params[:new_shipment])
      if (@new_shipment.save)
        mark_order_as_shipped(@new_shipment)
      end
    elsif(params[:commit] == 'Update')
      @shipment = Shipment.find(params[:upd_line])
      attrs = params[:shipment]["#{@shipment.id}"]
      @shipment.update_attributes(:comments => attrs[:comments])
    end
  end
  
  def view_order
    @cart = Cart.find params[:id]
  end
  
  def reviewed 
    cart = Cart.find params[:id]
    cart.orders.each do |order|
      order.update_attribute(:status, 1)
    end
    index
    render :action => 'index'
  end


  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        @user = username
        username == "tento" && Digest::SHA1.hexdigest(password) == "51cfdc3af28c718856cb835602f5ca9e9f569343"
      end
    end

  private
  def mark_cart_as_paid(cart)
    if(cart.amount_paid >= cart.total_amount)
      cart.update_attribute(:paid_at, Time.now)
    else
      cart.update_attribute(:paid_at, nil)
    end
  end
  
  def mark_order_as_shipped(shipment)
    order = shipment.order
    stat = order.shipments.map(&:complete)
    if(stat.index(true))
      order.update_attribute(:status, 4)
    end
  end

end 
