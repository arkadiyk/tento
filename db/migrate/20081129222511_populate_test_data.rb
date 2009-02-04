class PopulateTestData < ActiveRecord::Migration
  def self.up
    Supplier.create :name_en => 'Our Favorite Vegie Farm', 
      :long_name_en => 'This is a long description of our Favorite Farm',
      :shipping_rule => 'calculated_shipping,#weight,#amount,#ship_to'
      
    Supplier.create :name_en => 'Not As good as Another one', 
      :long_name_en => 'This is a long description of so-so farm',
      :shipping_rule => 'flat_shipping,580'

    Supplier.create :name_en => 'Our Favorite Bee farm', 
      :long_name_en => 'This is a long description of our Favorite Bee Farm',
      :shipping_rule => 'free_shipping'
      
    Supplier.create :name_en => 'Just a pickles farm', 
      :long_name_en => 'This is a long description for Pickles factory',
      :shipping_rule => 'calculated_shipping,#weight,#amount,#ship_to'

    ProductLine.create :name_en => 'Vegetables', :long_name_en => "Healthy Vegetables"
    ProductLine.create :name_en => 'Fruits', :long_name_en => "Sweet Fruits"
    ProductLine.create  :name_en => 'Bees', :long_name_en => "Honey, Roal Jelly, Propolus"
    ProductLine.create  :name_en => 'Canned/Bottled', :long_name_en => "Pickles, Jam, Preserves, etc"

  end

  def self.down
  end
end


