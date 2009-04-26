class ItemUnit < ActiveRecord::Base
  belongs_to :catalog_item, :counter_cache => true
  translatable_columns :name
  
  def supplier
    catalog_item.supplier
  end
   
  def label
    "#{name} / #{I18n.t(:yen, :a => price)}"
  end
end
