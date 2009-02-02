class Cart < ActiveRecord::Base
  has_many :orders
  has_many :line_items, :through => :orders
  has_many :item_units, :through => :line_items

  has_many :suppliers, :through => :orders
  
  def self.find_cart( id )
    begin
      find( id )
    rescue
      new
    end
  end

  def empty?
    orders.empty?
  end

  def size
    orders.map(&:size).sum
  end

end
