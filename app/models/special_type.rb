class SpecialType < ActiveRecord::Base
  has_many :current_specials
  has_many :catalog_items, :through => :current_specials
end
