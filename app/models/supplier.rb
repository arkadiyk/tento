class Supplier < ActiveRecord::Base
  has_many :orders
  has_many :catalog_items
  has_many :line_items, :through => :catalog_items

  translatable_columns :long_name, :name
end
