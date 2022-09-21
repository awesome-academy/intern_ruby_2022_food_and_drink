class ReportSaleMailer < ApplicationMailer
  def send_report_sales
    order_ids = Order.finished
      .where("updated_at", ">=", Time.now.beginning_of_month)
      .where("updated_at", "<=", Time.now.end_of_month)
      .pluck("id")

    order_details = OrderDetail.where(order_id: order_ids)
    @total = 0
    order_details.each do |f|
      @total += f.quantity * f.price
    end

    mail to: User.admin.first.email, subject: t("admin.orders.report_sale", month: Time.new.month)
  end
end
  