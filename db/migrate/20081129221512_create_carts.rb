class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.boolean :is_confirmed
      t.integer :pay_method
      t.boolean :is_paid
      t.integer :shipping_addr_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
