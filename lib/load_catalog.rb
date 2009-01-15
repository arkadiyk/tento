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
    end
    true
  end  
  
  def map_record(nl)
    nl["Supplier"] = map_supplier(nl["Supplier"])
    nl["ProductLine"] = map_pl(nl["ProductLine"])
    unit_fields = ["UnitEn","UnitJa","UnitWeight","UnitPrice","UnitPoints"]
    unit_fields.each do | fld |
      if nl[fld]
        nl[fld] = nl[fld].split(',')
      end
    end
  end
  
  def create_record(nl)
    id = nl["Supplier"] + '-' + nl["ProductLine"] + "-" + nl["ItemId"]
    ei = CatalogItem.find(:all, :conditions =>["item_id = ?", id])
    if ei.length > 0
      puts "Skipping #{id}"
      return # ignore for now
    end
    
    nc = CatalogItem.create :supplier_id => nl["Supplier"],
      :product_line_id => nl["ProductLine"],
      :item_id => id,
      :name_en => nl['NameEn'], 
      :long_name_en => nl['DescEn'],
      :image_file => nl['ImageFile']
      
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