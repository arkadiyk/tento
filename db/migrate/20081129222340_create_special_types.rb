class CreateSpecialTypes < ActiveRecord::Migration
  def self.up
    create_table :special_types do |t|
      t.string :name_en
      t.string :name_ja
      t.string :long_name_en
      t.string :long_name_ja
      t.string :type
      t.string :rule

      t.timestamps
    end
  end

  def self.down
    drop_table :special_types
  end
end
