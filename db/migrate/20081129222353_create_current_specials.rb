class CreateCurrentSpecials < ActiveRecord::Migration
  def self.up
    create_table :current_specials do |t|
      t.integer :catalog_item_id
      t.integer :special_type_id
      t.date :expires_on

      t.timestamps
    end
  end

  def self.down
    drop_table :current_specials
  end
end
