class CreateCatalogItems < ActiveRecord::Migration
  def self.up
    create_table :catalog_items do |t|
      t.integer :supplier_id    	# Supplier FK
      t.integer :product_line_id        # product line FK

      t.string :item_id
      t.string :name_en
      t.string :name_ja
      t.string :long_name_en
      t.string :long_name_ja
      t.string :image_file

      t.timestamps
    end
  end

  def self.down
    drop_table :catalog_items
  end
end
