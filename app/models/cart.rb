class Cart < ActiveRecord::Base
  ORDER_INIT_NUM = 77100
  
  has_many :orders
  has_many :line_items, :through => :orders

  has_many :suppliers, :through => :orders

  belongs_to :user
  belongs_to :ship_to, :class_name => "Address"
  
  named_scope :customer_orders, lambda { |user| { :conditions => ["confirmed_at is not null and user_id = ?", user] } }

   
  def empty?
    orders.empty?
  end

  def confirmed?
    !confirmed_at.nil?
  end

  def size
    orders.map(&:size).sum
  end
  
  def total_amount
    orders.map(&:amount_with_shipping).sum
  end
  
  def order_id
    "#{pay_method}00#{id + ORDER_INIT_NUM}" 
  end
  
  def updatable?
    orders.max(:status) < 2
  end
  
  def self.find_by_order_id(user, order_id)
    oid = order_id.sub(/^../,'').to_i - ORDER_INIT_NUM
    find :first, :conditions => {:id => oid, :user_id => user}
  end
  
  def title
    if size > 0
      "Cart total amount: ¥#{total_amount}"
    else
      "Cart is empty"
    end    
  end

end
