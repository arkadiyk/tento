class Order < ActiveRecord::Base
  belongs_to :supplier
  has_many :line_items
end
