class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    remove_column "name"
    add_column "users", "first_name", :string
    add_column "users", "last_name", :string
    add_column "users", "shipping_addr_id", :integer
    add_column "users", "verified", :boolean
    add_column "users", "points", :integer
  end

  def self.down
    remove_column   "users",  "points", "verified", "shipping_addr_id", "last_name", "first_name"
    add_column "users",  :name, :string, :limit => 100, :default => '', :null => true
  end

end
