class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.boolean :confirmed
      t.integer :pay_method
      t.boolean :paid
      t.boolean :canceled
      t.integer :ship_to_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
