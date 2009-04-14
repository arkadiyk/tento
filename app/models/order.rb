class Order < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :cart
  
  has_many :line_items
  has_many :item_units, :through => :line_items

  before_save :calculate_shipping_cost
  
  def empty?
    line_items.empty?
  end
  
  def size
    line_items.size
  end
  
  def amount
    line_items.map(&:item_amount).sum
  end
  
  def amount_with_shipping
    amount + shipping_cost
  end
 
  def shipping_cost_s
    shipping_cost == 0 ? "FREE" : "¥#{shipping_cost}"
  end
 
  def weight
    line_items.map(&:item_weight).sum
  end

  def points
    line_items.map(&:item_points).sum
  end
  
  def ship_to
    cart.ship_to
  end
   
  private
    def calculate_shipping_cost
      return if !supplier.shipping_rule
      
      ship_rule = supplier.shipping_rule.split(',')
      proc = ship_rule.shift
      args = ship_rule.map do |arg|
        arg.starts_with?('#') ? send(arg.sub('#','')) : arg
      end
      self.shipping_cost = ShippingRules.send(proc, *args)
      
    end
  
end
