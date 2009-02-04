class CartController < ApplicationController
  
  def index
    #TODO!!! check if it's not confirmed or shipped
    @cart = current_cart
  end

  def create    
    #TODO!!! check if it's not confirmed or shipped
    cart = current_cart
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
    #TODO!!! check if it's not confirmed or shipped
#    cart = Cart.find(session[:cart_id])
    @line = LineItem.find(params[:id])
    
    order = @line.order
    order.line_items.destroy(@line)
    
    if order.empty?
      @order_is_empty = true
      cart = order.cart
      cart.orders.destroy(order)
      @cart_is_empty = cart.empty?
    else
      order.save!
    end
  end
  
  def update
    #TODO!!! check if it's not confirmed or shipped
    @line = LineItem.find(params[:id])
    dir = params[:op]
    case dir
      when "up"
        @line.quantity += 1
        @line.save!
        @line.order.save!
      when "down"
        if(@line.quantity > 1)
          @line.quantity -= 1
          @line.save!
          @line.order.save!
        end
      else
        raise "Invalid operation"
    end
  end
  
  def clear_cart
    #TODO!!! check if it's not confirmed or shipped
    cart = Cart.find(session[:cart_id])
    cart.orders.each do |order|
      order.line_items.destroy_all
    end
    cart.orders.destroy_all
    
    render :partial => 'empty_cart'
  end
  
end
