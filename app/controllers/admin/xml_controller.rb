class Admin::XmlController < ApplicationController
  def index
    order_ids = Order.finished
      .where("updated_at", ">=", Time.now.beginning_of_month)
      .where("updated_at", "<=", Time.now.end_of_month)
      .pluck("id")

    @orders = OrderDetail.where(order_id: order_ids)
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="report_sales.xlsx"'
      }
    end
  end
end
