class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :cart_id
      t.integer :supplier_id
      t.integer :shipping_cost
      t.integer :status, :default => 0 # 0: cart, 1: confirmed, 2: sent to supplier, 3: suppl ask, 4: shipped
      t.boolean :canceled
 
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
