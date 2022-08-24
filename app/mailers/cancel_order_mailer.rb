class CancelOrderMailer < ApplicationMailer
  def reject_order order, email
    @order = order

    mail to: email, subject: "Reject order"
  end
end
