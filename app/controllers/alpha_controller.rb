class AlphaController < ApplicationController
  skip_before_filter :ajax_only
  before_filter :authenticate, :except => :pp 

  def pp
  end

  def update
  end
  
  def index
    @open_carts = Cart.confirmed
  end


  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "tento" && Digest::SHA1.hexdigest(password) == "51cfdc3af28c718856cb835602f5ca9e9f569343"
      end
    end

end
