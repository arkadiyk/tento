module CartHelper
  def update_cart_title
    
  end
  
  def in_the_cart(qty)
    qty && qty > 0 ? I18n.t("catalog.in_the_cart", :qty => qty) : ""
  end

end
