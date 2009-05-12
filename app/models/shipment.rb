class Shipment < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id, :message => "<< Select a farm"
  validates_presence_of :tracking_no
  
end
