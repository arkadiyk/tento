class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  belongs_to :item_unit
  belongs_to :supplier    # ugly. just for simplier queries

  before_create :update_fields_from_catalog_item
  
  # belongs_to :product_line, :through => :catalog_items
  def product_line
    catalog_item.product_line
  end
  
  def catalog_item
    item_unit.catalog_item
  end
  
  def item_name
    if catalog_item.item_units.size == 1
      catalog_item.name
    else
      "#{catalog_item.name}(#{item_unit.name})"
    end
  end
    
  private       
    def update_fields_from_catalog_item
      return if self.item_unit.nil? 
      self.supplier_id = self.item_unit.catalog_item.supplier_id
      self.price = self.item_unit.price
      self.points = self.item_unit.points
    end
  end
