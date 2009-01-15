class ItemUnit < ActiveRecord::Base
  belongs_to :catalog_item
  translatable_columns :name
  
  def label
    "#{name} / ¥#{price}"
  end
end
