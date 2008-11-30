class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.string :customer_id
      t.boolean :is_ordered

      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
