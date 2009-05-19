class OrderMailer < ActionMailer::Base
  

  def confirm(cart)
    subject    "Order Confirmation - #{cart.order_id}"
    recipients 'arc68@yahoo.com'
    from       'services@tentoexpress.jp'
    sent_on    Time.now
    content_type "text/html"
    
    body       :cart => cart
  end

  def sent(sent_at = Time.now)
    subject    'OrderMailer#sent'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
