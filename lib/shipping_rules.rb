class ShippingRules
  
  def self.free_shipping
    puts "*** FREE SHIPING"
    0
  end
  
  def self.flat_shipping(amount)
    puts "*** FLAT SHIPING: #{amount}"
    amount.to_i
  end
  
  def self.calculated_shipping(wheigh, order_amount, ship_to)
    puts "*** CALCULATED SHIPING: #{wheigh}, #{order_amount}, #{ship_to}"
    2 * order_amount
  end
end