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
    @payment = Payment.new
    if(params[:commit] == 'Add')
      @payment = Payment.new(params[:new_payment])
      @payment.cart = @cart
      @payment.save!
    elsif(params[:commit] == 'Update')
      @payment = Payment.find(params[:upd_line])
      attrs = params[:payment]["#{@payment.id}"]
      @payment.update_attributes(:comments => attrs[:comments])
    end
  end
  
  def shipments
    @cart = Cart.find params[:id]
  end


  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        @user = username
        username == "tento" && Digest::SHA1.hexdigest(password) == "51cfdc3af28c718856cb835602f5ca9e9f569343"
      end
    end

end
