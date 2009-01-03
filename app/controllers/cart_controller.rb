class CartController < ApplicationController
  def index
    cart = Cart.find_cart( session[ :cart_id ] )
    @cart_lines_by_supplier = cart.lines_by_supplier
    @count = cart.line_items.size
  end

  def create
    cart = Cart.find_cart( session[ :cart_id ] )
    @new_cart = cart.line_items.empty?
    
    catalog_item_id = params[ :cat_id ]
    quantity = params[ :qty ].to_i
    @line = cart.add_update_line( catalog_item_id, quantity )
    
    @new_line = @line.new_record?
    cart.save!
    @line.save!
    session[:cart_id] = cart.id

    sup_cart_lines = cart.line_items.find_all_by_supplier_id( @line.catalog_item.supplier_id )
    @supplier_total = { :id => @line.catalog_item.supplier_id,
                   :amount =>  sup_cart_lines.sum { |cl| cl.price * cl.quantity },
                   :weight =>  sup_cart_lines.sum { |cl| cl.catalog_item.unit_weight * cl.quantity } }
    
    # assuming all request are js:
    if( @new_line )
      case sup_cart_lines.size
        when 0 # wierd. should be at lease the one we just saved
          raise "wierd!!"
        when 1 # new for this supplier, create lines at the bottom
          @new_sup = true
          @id = cart.line_items.last.id
        else   # insert after last
          sup_cart_lines.delete(@line)
          @new_sup = false
          @id = sup_cart_lines.last.id
      end        
    end
    @count = cart.line_items.size
  end

  def destroy
    cart = Cart.find(session[:cart_id])
    @line = LineItem.find(params[:id])
    cart.line_items.destroy(@line)
    if cart.line_items.empty?
      @cart_is_empty = true
    else
      sup_cart_lines = cart.line_items.find_all_by_supplier_id( @line.catalog_item.supplier_id )
      if sup_cart_lines.empty?
        @last_supplier = true
      end
    end
    @count = cart.line_items.size
  end
  
  def update
    @line = LineItem.find(params[:id])
    dir = params[:op]
    case dir
      when "up"
        @line.quantity += 1
        @line.save!
      when "down"
        if(@line.quantity > 1)
          @line.quantity -= 1
          @line.save!
        end
      else
        raise "Invalid operation"
    end
  end
  
end
