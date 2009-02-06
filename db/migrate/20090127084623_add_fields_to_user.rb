class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column "users", "shipping_addr_id", :integer
    add_column "users", "verified", :boolean
    add_column "users", "points", :integer
  end

  def self.down
    remove_column   "users",  "points", "verified", "shipping_addr_id"
  end

end
