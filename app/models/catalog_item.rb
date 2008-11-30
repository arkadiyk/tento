class CatalogItem < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :product_line
  has_many :current_specials
  has_many :special_types, :through => :current_specials
end
