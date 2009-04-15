class CreateCatalogItems < ActiveRecord::Migration
  def self.up
    create_table :catalog_items do |t|
      t.integer :supplier_id    	# Supplier FK

      t.string :item_id
      t.string :name_en
      t.string :name_ja
      t.string :long_name_en
      t.string :long_name_ja
      t.string :image_file

      t.timestamps
    end
  
    # generate the join table
    create_table :catalog_items_product_lines, :id => false do |t|
        t.integer :catalog_item_id
        t.integer :product_line_id
    end

  end
 

  def self.down
    drop_table :catalog_items_product_lines
    drop_table :catalog_items
  end
end
