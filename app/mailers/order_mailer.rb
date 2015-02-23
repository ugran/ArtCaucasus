class OrderMailer < ActionMailer::Base
  default from: "orderconfirmation@artiveria.com"

  def order_confirmation(user, order)
  	@user = user
  	@order = order
  	mail(to: user.email, subject: 'Your order at Artiveria.com has been confirmed.', bcc: 'sopho@artiveria.com')
  end

  def request_alert(email,item)
  	@email = email
  	@item = item
  	mail(to: 'sopho@artiveria.com', subject: 'New Price Request.')
  end

end
