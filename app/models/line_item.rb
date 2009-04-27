class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item_unit

  before_create :update_fields_from_catalog_item
  
  # belongs_to :product_line, :through => :catalog_items
#  def product_line
#    catalog_item.product_line
#  end
  
  def catalog_item
    item_unit.catalog_item
  end
  
  def item_name
#    if catalog_item.item_units.size == 1
      catalog_item.name
#    else
#      "#{catalog_item.name}(#{item_unit.name})"
#    end
  end

  def item_amount
    price * quantity  
  end
  
  def item_weight
    item_unit.weight * quantity
  end
     
  def item_points
    points * quantity
  end
  
  private       
    def update_fields_from_catalog_item
      return if self.item_unit.nil? 
      self.price = self.item_unit.price
      self.points = self.item_unit.points
    end
  end
