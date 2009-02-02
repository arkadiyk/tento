class ItemUnit < ActiveRecord::Base
  belongs_to :catalog_item
  translatable_columns :name
  
  def supplier
    catalog_item.supplier
  end
   
  def label
    "#{name} / ¥#{price}"
  end
end
