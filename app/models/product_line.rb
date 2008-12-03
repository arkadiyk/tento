class ProductLine < ActiveRecord::Base
  has_many :catalog_items
  has_many :line_items, :through => :catalog_items
end
