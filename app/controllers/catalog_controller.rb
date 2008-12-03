class CatalogController < ApplicationController
  def items
    cat = params[:cat]
    case cat
      when 'sp' # specials
        items = [] # not at the moment
      when 'pl' # product_line
        header_obj = :supplier
        items = CatalogItem.find_all_by_product_line_id(params[:id], :include => header_obj)
      when 'su' # supplier
        header_obj = :product_line
        items = CatalogItem.find_all_by_supplier_id(params[:id], :include => header_obj)
    end
    
    @cat_items = {};
    items.each do |item|
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
