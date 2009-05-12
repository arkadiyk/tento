class Cart < ActiveRecord::Base
  ORDER_INIT_NUM = 77100
  
  has_many :orders
  has_many :line_items, :through => :orders

  has_many :suppliers, :through => :orders
  
  has_many :payments
  has_many :shipments, :through => :orders

  belongs_to :user
  belongs_to :ship_to, :class_name => "Address"
  
  named_scope :customer_orders, lambda { |user| { :conditions => ["confirmed_at is not null and user_id = ?", user] } }
  
  named_scope :confirmed, :conditions => "confirmed_at is not null"


  after_save :update_user_points
   
  def empty?
    orders.empty?
  end

  def confirmed?
    !confirmed_at.nil?
  end
  
  def paid?
    !paid_at.nil?
  end
  
  def canceled?
    !canceled_at.nil?
  end
  
  def shipping_status
    ostat = orders.map(&:status).uniq
    if(ostat.length == 1 && ostat[0] == 4)
      I18n.t("order.status.shipped")
    elsif(ostat.length > 1 && ostat.index(4))
      I18n.t("order.status.part_shipped")
    else
      I18n.t("order.status.not_shipped")
    end
  end
  
  def payment_status
    if amount_paid == 0
      I18n.t("order.status.not_paid")
    elsif amount_paid == total_amount
      I18n.t("order.status.paid")
    elsif amount_paid < total_amount
      I18n.t("order.status.part_paid")
    else
      I18n.t("order.status.overpaid")
    end
  end

  def size
    orders.map(&:size).sum
  end
  
  def total_amount
    orders.map(&:amount_with_shipping).sum
  end
  
  def total_points
    orders.map(&:points).sum
  end
 
  def amount_paid
    payments.map(&:amount).sum
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
  
  def ordered_at
    confirmed_at.to_s(:db)
  end
 
  def title
    if size > 0
      I18n.t("cart.label_total", :amount => total_amount)
    else
      I18n.t("cart.label_empty")
    end    
  end
  
  def item_qty_map
    the_map = {}
    line_items.each do |i| 
      the_map[i.item_unit.catalog_item.id] ||= 0
      the_map[i.item_unit.catalog_item.id] += i.quantity
    end
    the_map
  end
  
  private
    def update_user_points
      #TODO introduce "orders" name scope into User object
      if changed.index("confirmed_at")
        user.points = Cart.customer_orders(user).map(&:total_points).sum
        user.save!
      end
    end

end
