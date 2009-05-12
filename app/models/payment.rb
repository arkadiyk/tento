class Payment < ActiveRecord::Base
  belongs_to :cart
  validates_presence_of :amount, :transaction_id
end
