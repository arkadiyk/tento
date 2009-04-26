class PopulateTestData < ActiveRecord::Migration
  def self.up
    Supplier.create :name_en => 'AizuIkiIki',
      :name_ja => '会津活活',
      :long_name_en => 'Aizu IkiIki Shizenmura',
      :long_name_ja => '会津活活自然村',
      :shipping_rule => 'calculated_shipping,#weight,#amount,#ship_to'
      
    Supplier.create :name_en => 'Saito Kokichi', 
      :name_ja => '斉藤幸吉',
      :long_name_en => 'Saito Kokichi Farm',
      :long_name_ja => '斉藤農家',
      :shipping_rule => 'flat_shipping,580'

    Supplier.create :name_en => 'Aizu Bandai Bee Farm', 
      :name_ja => '会津磐梯蜂蜜',
      :shipping_rule => 'free_shipping'
#1      
    vg = ProductLine.create :name_en => 'Vegetables', :long_name_en => "Root Veggie, Green Veggie, Beans, Herbs",
      :name_ja => '野菜', :long_name_ja => '根菜、緑色野菜、豆類、ハーブ'
#2
      vg.children.create  :name_en => 'Other Veggies', :name_ja => 'その他野菜' 
      vg.children.create  :name_en => 'Root Veggies',  :name_ja => '根菜'
      vg.children.create  :name_en => 'Green Veggies', :name_ja => '緑色野菜'
      vg.children.create  :name_en => 'Beans', :name_ja => '豆類'
      vg.children.create  :name_en => 'Herbs', :name_ja => 'ハーブ'
      vg.children.create  :name_en => 'Mashrooms', :name_ja => 'きのこ'
    
    ProductLine.create :name_en => 'Fruits', :name_ja => 'くだもの'
    ProductLine.create  :name_en => 'Honey Products', :long_name_en => "Honey, Royal Jelly, Propolis",
      :name_ja => '蜂蜜製品', :long_name_ja => '蜂蜜、ロイヤルゼリー、プロポリス'
    ProductLine.create  :name_en => 'Canned/Bottled', :long_name_en => "Pickles, Oil, Juice, Jam, etc",
      :name_ja => '缶、瓶詰め', :long_name_ja => 'ピクルス、油、ジャム、ジュース等'
    ProductLine.create :name_en => 'Rice', :name_ja => '米'
    
    ProductLine.create :name_en => 'Produce Boxes', :name_ja => ''

# Specials
    SpecialType.create :name_en => 'Produce Boxes', :name_ja => ''
    SpecialType.create :name_en => 'Seasonal', :name_ja => ''
    SpecialType.create :name_en => 'Extra Points', :name_ja => ''
    SpecialType.create :name_en => 'Free Delivery', :name_ja => ''

  end

  def self.down
  end
end


