class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def add_update_line( catalog_item_id, quantity ) 
    line = find_create_by_catalog_item_id( catalog_item_id )
    line.quantity ||= 0
    line.quantity += quantity
    line
  end

  private
    def find_create_by_catalog_item_id( ci_id )
      items = line_items.find_all_by_catalog_item_id( ci_id )
      case items.size
        when 0
          line_items.build(:catalog_item_id => ci_id)
        when 1
          items.first
        else
          raise "Cart Line is not unique! (ci_id == #{ci_id}"
      end
    end

end
