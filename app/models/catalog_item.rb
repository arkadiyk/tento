class CatalogItem < ActiveRecord::Base
  belongs_to :supplier
  has_and_belongs_to_many :product_line
  has_many :item_units,  :dependent => :destroy
  has_many :current_specials
  has_many :special_types, :through => :current_specials

  translatable_columns :long_name, :name, :desc
  
  def label
    long_name.blank? ? name : "#{name}(#{long_name})"
  end
    
end
