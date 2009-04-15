#!/usr/bin/ruby -w

require "csv"  

class LoadCatalog
  def load_file
    filename = 'data/ProductList.csv'
    
    results = CSV.read(filename) 
    header_line = results.shift
    results.each do |line|
      if !line[0]
        next
      end
      nl = Hash[*header_line.zip(line).flatten]
      map_record(nl)
      create_record(nl)
      puts "Record created #{nl.inspect}\n"
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
    nl["Supplier"] = map_supplier(nl["Supplier"])
    nl["ProductLine"] = map_pl(nl["ProductLine"])
  end
  
  def create_record(nl)
    id = "#{nl["Supplier"]}-#{nl["ItemId"]}"
    ei = CatalogItem.find(:all, :conditions =>["item_id = ?", id])
    if ei.length > 0
      puts "Skipping #{id}"
      return # ignore for now
    end
    
    nc = CatalogItem.create :supplier_id => nl["Supplier"],
      :item_id => id,
      :name_en => nl['NameEn'], 
      :long_name_en => nl['DescEn'],
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

  end
  
  def map_supplier(id)
    id
  end
  
  def map_pl(id)
    id
  end
  
end

lc = LoadCatalog.new
lc.load_file
