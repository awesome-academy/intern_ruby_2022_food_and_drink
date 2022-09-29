class Admin::OrdersController < ApplicationController
  before_action :find_order, only: %i(edit update)
  def index
    @pagy, @orders = pagy Order.all,
                          items: Settings.const.paginate
  end

  def edit; end

  def update
    case status_params[:status]
    when "rejected", "approved"
      approve_or_reject_order
    when "processing"
      processing_order
    else
      raise StandardError
    end
  end

  private

  def run_update
    raise StandardError unless @order.update status_params

    OrderMailer.status(@order).deliver_later
  end

  def approve_or_reject_order
    raise StandardError unless @order.status == "pending"

    run_update
  end

  def processing_order
    raise StandardError unless @order.status == "approved"

    run_update
  end

  def status_params
    params.require(:order).permit(:status)
  end

  def find_order
    @order = find_object Order, params[:id]
  end
end
