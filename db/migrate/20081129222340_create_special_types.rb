class CreateSpecialTypes < ActiveRecord::Migration
  def self.up
    create_table :special_types do |t|
      t.string :type
      t.string :rule

      t.timestamps
    end
  end

  def self.down
    drop_table :special_types
  end
end
