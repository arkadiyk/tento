class CartController < ApplicationController
  
  def index
    @cart = Cart.find_cart(session[:cart_id])
  end

  def create    
    cart = Cart.find_cart(session[:cart_id])
    @new_cart = cart.empty?
    
    unit_id = params[:unit_id]
    quantity = params[:qty].to_i
    line_unit = ItemUnit.find(unit_id)
    supplier = line_unit.catalog_item.supplier
    
    orders = cart.orders.find_all_by_supplier_id(supplier.id)
    case orders.size
      when 0 # new order
        @new_order = true
        @order = cart.orders.build(:supplier => supplier)
      when 1 # existing one
        @new_order = false
        @order = orders[0]
      else
        raise "DB inconcistency: not uniq supplier #{supplier.id} in cart #{cart.id}"
    end
    
    lines = @order.line_items.find_all_by_item_unit_id(unit_id)
    case lines.size
      when 0 # new line
        @new_line = true
        @line = @order.line_items.build(:item_unit => line_unit, :quantity => quantity)
      when 1 # existing one
        @new_line = false
        @line = lines[0]
        @line.quantity += quantity
      else
        raise "DB inconcistency: not uniq unit #{unit_id} in order #{@order.id}"
    end
      
    Cart.transaction do
      @line.save!
      @order.save!
      cart.save!
    end
    
    session[:cart_id] = cart.id
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
