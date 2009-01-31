class ShippingRules
  def self.free_shipping
    0
  end
  
  def self.flat_shipping(amount)
    amount
  end
  
  def self.calculated_shipping(wheigh, area, order_amount)
    123
  end
end