class OrderMailer < ActionMailer::Base
  default from: "orderconfirmation@artiveria.com"

  def order_confirmation(user, order)
  	@user = user
  	@order = order
  	mail(to: user.email, subject: 'Your order at Artiveria.com has been confirmed.', bcc: 'logistics@artiveria.com')
  end

end
