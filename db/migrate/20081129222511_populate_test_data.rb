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

    CatalogItem.create :name_en => 'Carrots', :product_line => pl_vegies, :long_name_en => 'The best Carrots. This could be very long description of the product. Hyperlinks should be allowed as well',  
                             :image_file => 'carrots_large.png',  
                             :price => 250, :unit_weight => 0.5, :unit_en => '500g', :points => 25, :supplier => sup_vegie

    CatalogItem.create :name_en => 'Tomatos', :product_line => pl_vegies, :long_name_en => 'The best Tomatos, very Red. This could be very long description of the product. Hyperlinks should be allowed as well',  
                             :image_file => 'tomatos_large.png', 
                             :price => 450, :unit_weight => 0.5, :unit_en => '500g', :points => 24, :supplier => sup_vegie

    CatalogItem.create :name_en => 'Cabage', :product_line => pl_vegies, :long_name_en => 'The very best Cabage. This could be very long description of the product. Hyperlinks should be allowed as well', 
                             :image_file => 'cabage_large.png', 
                             :price => 350, :unit_weight => 1, :unit_en => '1kg', :points => 35, :supplier => sup_vegie

    CatalogItem.create :name_en => 'Broccoli', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli. This could be very long description of the product. Hyperlinks should be allowed as well',  
                             :image_file => 'broccoli_large.png',  
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie

    CatalogItem.create :name_en => 'Zukkini', :product_line => pl_vegies, :long_name_en => 'Very BIG Zukkini',  
                             :image_file => 'broccoli_large.png',
                             :price => 200, :unit_weight => 2, :unit_en => '2kg', :points => 20, :supplier => sup_vegie
    CatalogItem.create :name_en => 'Broccoli', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie

    CatalogItem.create :name_en => 'Broccoli 1', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli 1',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie1
   CatalogItem.create :name_en => 'Broccoli 2', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli 2',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie1
   CatalogItem.create :name_en => 'Broccoli 3', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli 3',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie1
   CatalogItem.create :name_en => 'Broccoli 4', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli 4',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie1
   CatalogItem.create :name_en => 'Broccoli 5', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli 5',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie1
   CatalogItem.create :name_en => 'Broccoli 6', :product_line => pl_vegies, :long_name_en => 'The best green Broccoli 6',  
                             :image_file => 'broccoli_large.png', 
                             :price => 300, :unit_weight => 1, :unit_en => '1kg', :points => 30, :supplier => sup_vegie1



    CatalogItem.create :name_en => 'Pickled Redish', :product_line => pl_pickles, :long_name_en => 'The best Pickled Round Redish', 
                             :image_file => 'carrots_large.png', :image_file => 'carrots_small.png', 
                             :price => 250, :unit_weight => 1, :unit_en => '1jar', :points => 25, :supplier => sup_pickles

    CatalogItem.create :name_en => 'Apples', :product_line => pl_fruits, :long_name_en => 'The best round Apples. This could be very long description of the product. Hyperlinks should be allowed as well',  
                             :image_file => 'carrots_large.png', :image_file => 'carrots_small.png', 
                             :price => 250, :unit_weight => 0.5, :unit_en => '500g', :points => 25, :supplier => sup_fruits

    CatalogItem.create :name_en => 'Pears', :product_line => pl_fruits, :long_name_en => 'The best ever Pears', 
                             :image_file => 'carrots_large.png', :image_file => 'carrots_small.png',
                             :price => 250, :unit_weight => 0.5, :unit_en => '500g', :points => 25, :supplier => sup_fruits

    
  end

  def self.down
  end
end


