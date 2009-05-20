class OrderMailer < ActionMailer::Base
  

  def confirm(cart)
    subject    I18n.t('order.email.confirm_subject', :id => cart.order_id)
    recipients cart.user.email
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
