class CatalogController < ApplicationController
  def items
  end

  def categories
    @pl = ProductLine.find :all
    @su = Supplier.find :all
  end

end
