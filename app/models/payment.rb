class Payment < ActiveRecord::Base
  belongs_to :cart
end
