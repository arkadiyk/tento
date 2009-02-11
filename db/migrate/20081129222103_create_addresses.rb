class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :postal_code 
      t.string :prefecture
      t.string :city
      t.string :address
      t.string :phone
      
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
