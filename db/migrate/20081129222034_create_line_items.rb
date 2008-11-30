class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :order_id
      t.integer :customer_id
      t.integer :catalog_item_id
      t.integer :quantity,  :default => 0
      t.integer :price
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
