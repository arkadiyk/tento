class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.datetime :confirmed_at
      t.string  :pay_method
      t.datetime :paid_at
      t.datetime :canceled_at
      t.integer :ship_to_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
