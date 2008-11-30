class Address < ActiveRecord::Base
  validates_format_of :postal_code, :with => /\d{3}-\d{4}/
  validates_presence_of :line1, :line2, :postal_code
end
