class CreateProductLines < ActiveRecord::Migration
  def self.up
    create_table :product_lines do |t|
      t.string :name_en
      t.string :name_ja
      t.string :long_name_en
      t.string :long_name_ja

      t.timestamps
    end
  end

  def self.down
    drop_table :product_lines
  end
end
