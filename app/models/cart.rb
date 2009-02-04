class Cart < ActiveRecord::Base
  has_many :orders
  has_many :line_items, :through => :orders

  has_many :suppliers, :through => :orders

  belongs_to :user
  belongs_to :ship_to, :class_name => "Address"

   
  def empty?
    orders.empty?
  end

  def size
    orders.map(&:size).sum
  end
  
  def total_amount
    orders.map(&:amount_with_shipping).sum
  end
  
  def title
    if size > 0
      "Cart total amount: ¥#{total_amount}"
    else
      "Cart is empty"
    end    
  end

end
