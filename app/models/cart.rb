class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :item_units, :through => :line_items

  def self.find_cart( id )
    begin
      find( id )
    rescue
      new
    end
  end

  def lines_by_supplier
    lines = {}
    line_items.each do |li|
        su = li.supplier
        lines[su] ||= []
        lines[su] << li
    end
    lines
  end    
    
  def add_update_line( unit_id, quantity ) 
    line = find_create_by_unit_id( unit_id )
    line.quantity ||= 0
    line.quantity += quantity
    line
  end

  private
    def find_create_by_unit_id( unit_id )
      items = line_items.find_all_by_item_unit_id( unit_id )
      case items.size
        when 0
          line_items.build(:item_unit_id => unit_id)
        when 1
          items.first
        else
          raise "Cart Line is not unique! (unit_id == #{unit_id}"
      end
    end

end
