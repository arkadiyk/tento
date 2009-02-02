class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :item_unit_id
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
