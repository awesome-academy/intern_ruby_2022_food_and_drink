class OrderReceivedMailer < ApplicationMailer
  def order_received order, email
    @order = order

    mail to: email, subject: "We've received your order"
  end
end
