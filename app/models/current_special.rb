class CurrentSpecial < ActiveRecord::Base
  belongs_to :special_type
  belongs_to :catalog_item
end
