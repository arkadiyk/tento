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
      puts "Skipping #{id}"
      return false
    end
    
    nc = CatalogItem.create :supplier_id => nl["Supplier"],
      :item_id => id,
      :name_en => nl['NameEn'], 
      :long_name_en => nl['LongNameEn'],
      :desc_en => nl['DescEn'],
      :name_ja => nl['NameJa'], 
      :long_name_ja => nl['LongNameJa'],
      :desc_ja => nl['DescJa'],
      :image_file => nl['ImageFile']
      
    nl["ProductLine"].each do |pl_id|
      nc.product_line << ProductLine.find(pl_id)
    end
      
    nl['UnitPrice'].each_index do |i|
      ItemUnit.create :price => nl['UnitPrice'][i], 
        :weight => nl['UnitWeight'][i], 
        :name_en => nl['UnitEn'] ? nl['UnitEn'][i] : nil, 
        :name_ja => nl['UnitJa'] ? nl['UnitJa'][i] : nil, 
        :points => nl['UnitPoints'][i],
        :catalog_item => nc
    end
    true
  end
  
  def map_supplier(name)
    case name
      when "AizuIkiIki" then 1
      when "Saito Kokichi" then 2  
    end
  
  end
  
  def map_pl(name)
    case name
      when "vegetable" then 2
      when "root" then 3
      when "leaf" then 4
      when "beans" then 5
      when "herb" then 6
      when "mashroom" then 7
      when "fruit" then 8
      when "picles" then 10
      when "rice" then 11
    end
  end
  
end

lc = LoadCatalog.new
lc.load_file
