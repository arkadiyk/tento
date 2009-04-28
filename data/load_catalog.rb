#!/usr/bin/ruby -w

require "csv"  

class LoadCatalog
  def load_file
    filename = 'data/ProductListNew.csv'
    
    results = CSV.read(filename) 
#    p results
    
    header_line = results.shift
#    p header_line
#    p results


# DEACTIVATE ALL CatalogItems and ItemUnits
    CatalogItem.update_all(:active => false)
    ItemUnit.update_all(:active => false)
    
    
    results.each do |line|      
      if line[0].empty?
        next
      end
      p line

      nl = Hash[*header_line.zip(line).flatten]
      map_record(nl)
      succ = create_record(nl)
      puts "Record created #{nl.inspect}\n" if succ
    end
    true
  end  
  
  def map_record(nl)
    unit_fields = ["UnitEn","UnitJa","UnitWeight","UnitPrice","UnitPoints","ProductLine"]
    unit_fields.each do | fld |
      if nl[fld]
        nl[fld] = nl[fld].split(',')
      end
    end
    p nl
    nl["Supplier"] = map_supplier(nl["Supplier"])
    nl["ProductLine"] = nl["ProductLine"].map{|ln| map_pl(ln)}
  end
  
  def create_record(nl)
    id = "#{nl["Supplier"]}-#{nl["ItemId"]}"
    ei = CatalogItem.find(:all, :conditions =>["item_id = ?", id])
    if ei.length > 0
      puts "Updating #{id}"
      raise "\n\nNot Unique #{id}!!!\n\n" if(ei.length > 1)
      nc = ei[0]
      nc.product_line = []  #reasign categories
    else
      puts "Creating #{id}"
      nc = CatalogItem.new
    end
    
    nc.update_attributes! :supplier_id => nl["Supplier"],
      :item_id => id,
      :name_en => nl['NameEn'], 
      :long_name_en => nl['LongNameEn'],
      :desc_en => nl['DescEn'],
      :name_ja => nl['NameJa'], 
      :long_name_ja => nl['LongNameJa'],
      :desc_ja => nl['DescJa'],
      :image_file => nl['ImageFile'],
      :in_stock => nl['InStock'] == 'Y',
      :active => true
      
    nl["ProductLine"].each do |pl_id|
      nc.product_line << ProductLine.find(pl_id)
    end
      
    nl['UnitWeight'].each_index do |i|
      uw = nl['UnitWeight'][i]
      item = nc.item_units.first :conditions =>["weight = ?", uw]
      
      if item.nil? 
        item = ItemUnit.new :weight => uw, :catalog_item => nc
      end
      
      item.update_attributes! :price => nl['UnitPrice'][i], 
        :name_en => nl['UnitEn'] ? nl['UnitEn'][i] : nil, 
        :name_ja => nl['UnitJa'] ? nl['UnitJa'][i] : nil, 
        :points => nl['UnitPoints'][i],
        :active => true
    end
    true
  end
  
  def map_supplier(name)
    case name
      when "AizuIkiIki" then 1
      when "Saito Kokichi" then 2
      when "Bandai Bee Farm" then 3
    end
  
  end
  
  def map_pl(name)
    case name
#2 'Green Veggies', :name_ja => '緑色野菜'
#3 'Fruit Veggies', :name_ja => '緑色野菜'
#4 'Root Veggies',  :name_ja => '根菜'
#5 'Mountain(wild) Veggies',  :name_ja => '根菜'
#6 'Potatos', :name_ja => '豆類'
#7 'Beans', :name_ja => '豆類'
#8 'Mashrooms', :name_ja => 'きのこ'
#9 'Herbs', :name_ja => 'ハーブ'
#10 'Spices', :name_ja => 'ハーブ'
#11 'Other Veggies', :name_ja => 'その他野菜' 
            
      when "leaf" then 2
      when "fruit-veggie" then 3
      when "root" then 4
      when "mountain-veggie" then 5
      when "potato" then 6
      when "beans" then 7
      when "mashroom" then 8
      when "herb" then 9
      when "spice" then 10
      when "other-veggie" then 11
      # =====
      when "fruit" then 12
      when "honey" then 13
      when "picles" then 14
      when "rice" then 15
    end
  end
  
end

lc = LoadCatalog.new
lc.load_file
