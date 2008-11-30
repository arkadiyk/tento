class CreateCatalogItems < ActiveRecord::Migration
  def self.up
    create_table :catalog_items do |t|
      t.integer :supplier_id    	# Supplier FK
      t.integer :product_line_id        # product line FK

      t.string :name_en
      t.string :name_ja
      t.string :long_name_en
      t.string :long_name_ja
      t.string :unit_en                     # Unit i.e 1kg, 500g, pc, bottle, etc
      t.string :unit_ja
      t.decimal :unit_weight, :scale => 3
      t.integer :price, :scale => 0         # JPY
      t.integer :points                     # points/unit ( usually 10% of unit price )
      t.string :image_file

      t.timestamps
    end
  end

  def self.down
    drop_table :catalog_items
  end
end
