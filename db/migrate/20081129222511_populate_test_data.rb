class PopulateTestData < ActiveRecord::Migration
  def self.up
    sup_vegie = Supplier.create :name_en => 'Our Favorite Vegie Farm', :long_name_en => 'This is a long description of our Favorite Farm'
    sup_vegie1 = Supplier.create :name_en => 'Not As good as Another one', :long_name_en => 'This is a long description of so-so farm'
    sup_bee = Supplier.create :name_en => 'Our Favorite Bee farm', :long_name_en => 'This is a long description of our Favorite Bee Farm'
    sup_pickles = Supplier.create :name_en => 'Just a pickles farm', :long_name_en => 'This is a long description for Pickles factory'
    sup_fruits = sup_vegie

    pl_vegies = ProductLine.create :name_en => 'Vegetables', :long_name_en => "Healthy Vegetables"
    pl_fruits = ProductLine.create :name_en => 'Fruits', :long_name_en => "Sweet Fruits"
    pl_bees = ProductLine.create  :name_en => 'Bees', :long_name_en => "Honey, Roal Jelly, Propolus"
    pl_pickles = ProductLine.create  :name_en => 'Canned/Bottled', :long_name_en => "Pickles, Jam, Preserves, etc"

  end

  def self.down
  end
end


