class CreateItemUnits < ActiveRecord::Migration
  def self.up
    create_table :item_units do |t|
      t.integer :catalog_item_id

      t.string :name_en                     # Unit i.e 1kg, 500g, pc, bottle, etc
      t.string :name_ja
      t.decimal :weight, :scale => 3
      t.integer :price
      t.integer :points                     # points/unit ( usually 10% of unit price )
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :item_units
  end
end
