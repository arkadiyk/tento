class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  belongs_to :catalog_item

  before_create :update_fields_from_catalog_item

  # belongs_to :supplier, :through => :catalog_items
  def supplier
    catalog_item.supplier
  end
  
  # belongs_to :product_line, :through => :catalog_items
  def product_line
    catalog_item.product_line
  end
  
  private    
    def update_fields_from_catalog_item
      return if self.catalog_item.nil? 
      self.price = self.catalog_item.price
      self.points = self.catalog_item.points
    end
  end
