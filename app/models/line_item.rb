class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
  belongs_to :catalog_item

  # belongs_to :supplier, :through => :catalog_items
  def supplier
    catalog_item.supplier
  end
end
