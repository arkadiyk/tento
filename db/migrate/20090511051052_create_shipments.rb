class CreateShipments < ActiveRecord::Migration
  def self.up
    create_table :shipments do |t|
      t.integer :order_id
      t.string :tracking_no
      t.decimal :weight
      t.decimal :price
      t.boolean :complete, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :shipments
  end
end
