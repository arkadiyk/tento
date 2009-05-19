class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column "users", "shipping_addr_id", :integer
    add_column "users", "verified", :boolean
    add_column "users", "points", :integer
    add_column "users", "default_locale", :string
  end

  def self.down
    remove_column   "users",  "default_locale", "points", "verified", "shipping_addr_id"
  end

end
