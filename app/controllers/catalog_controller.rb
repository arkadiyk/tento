class CatalogController < ApplicationController
  def items
    cat = params[:p1]
    case cat
      when 'sp' # specials
        item_list = [] # not at the moment
      when 'pl' # product_line
        header_obj = :supplier
        item_list = CatalogItem.find_all_by_product_line_id(params[:p2], {:include => header_obj})
      when 'su' # supplier
        header_obj = :product_line
        item_list = CatalogItem.find_all_by_supplier_id(params[:p2], {:include => header_obj})
    end
    
    @cat_items = {};
    item_list.each do |item|
      hdr = item.send(header_obj)
      @cat_items[hdr] ||= []
      @cat_items[hdr] << item
    end
    
  end

  def categories
    @pl = ProductLine.find :all
    @su = Supplier.find :all
  end

end
