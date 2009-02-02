class Order < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :cart
  
  has_many :line_items
  has_many :item_units, :through => :line_items
  
  def empty?
    line_items.empty?
  end
  
  def size
    line_items.size
  end
  
  def total_amount
    line_items.map(&:item_amount).sum
  end
 
  def total_weight
    line_items.map(&:item_weight).sum
  end

  def total_points
    line_items.map(:item_points).sum
  end
  
end
