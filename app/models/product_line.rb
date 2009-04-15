class ProductLine < ActiveRecord::Base
  acts_as_tree

  has_and_belongs_to_many :catalog_items
#  has_many :line_items, :through => :catalog_items

  translatable_columns :long_name, :name
  
  def <=>(other) 
    self.id <=> other.id 
  end 


  def self_and_all_children
    [self,children.collect(&:self_and_all_children)].flatten
  end 
end
