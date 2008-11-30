class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name_en
      t.string :name_ja
      t.string :long_name_en
      t.string :long_name_ja
      t.integer :address_id
      t.string :shipping_rule

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
