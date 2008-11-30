class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :supplier_id
      t.integer :cart_id
      t.integer :customer_id
      t.integer :shipping_cost
      t.integer :shipping_addr_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
