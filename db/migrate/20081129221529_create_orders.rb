class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :cart_id
      t.integer :supplier_id
      t.integer :shipping_cost
      t.boolean :is_shipped

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
