class CatalogController < ApplicationController
  def items
    @item_cart_map = current_cart.item_qty_map
    
    @cat_items = {}; @ids = {}
    cat = params[:p1]
    case cat
      when 'sp' # specials
        item_list = [] # not at the moment

      when 'pl' # product_line
        pl = ProductLine.find(params[:p2])
        cs = pl.children
        cs = [pl] if cs.empty?
        cs.each do |spl|
          @ids[spl] = "ch_#{cat}_#{params[:p2]}_#{spl.id}"
          @cat_items[spl] = ProductLine.find(spl.id).catalog_items
        end

      when 'su' # supplier
        item_list = CatalogItem.find_all_by_supplier_id(params[:p2])
        item_list.each do |item|
          hdr = item.product_line
          hdr.each do |hd|
            @ids[hd] = "ch_#{cat}_#{params[:p2]}_#{hd.id}"
            @cat_items[hd] ||= []
            @cat_items[hd] << item
          end
        end
      
    end
  end

  def categories
    @pl = ProductLine.roots 
    @su = Supplier.all
    @sp = SpecialType.all
  end

end
