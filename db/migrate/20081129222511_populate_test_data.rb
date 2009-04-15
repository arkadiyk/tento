class PopulateTestData < ActiveRecord::Migration
  def self.up
    Supplier.create :name_en => 'Aizu Iki Iki', 
      :long_name_en => 'Natural Veggie Farm',
      :shipping_rule => 'calculated_shipping,#weight,#amount,#ship_to'
      
    Supplier.create :name_en => 'Saito Kokichi', 
      :long_name_en => 'Rice Farm',
      :shipping_rule => 'flat_shipping,580'

    Supplier.create :name_en => 'Aizu Bee Farm', 
      :shipping_rule => 'free_shipping'
      
    vg = ProductLine.create :name_en => 'Vegetables', :long_name_en => "Root Veggie, Leaf Veggie, Beans, Herbs"
    vg.children.create  :name_en => 'Root Veggies'
    vg.children.create  :name_en => 'Leaf Veggies'
    vg.children.create  :name_en => 'Beans'
    vg.children.create  :name_en => 'Herbs'
    
    ProductLine.create :name_en => 'Fruits'
    ProductLine.create  :name_en => 'Bee Products', :long_name_en => "Honey, Royal Jelly, Propolis"
    ProductLine.create  :name_en => 'Canned/Bottled', :long_name_en => "Pickles, Oil, Juice, Jam, etc"
    ProductLine.create :name_en => 'Rice'

  end

  def self.down
  end
end


