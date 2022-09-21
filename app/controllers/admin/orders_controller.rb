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
    when "finished"
      finished_order
    else
      raise StandardError
    end
  end

  private

  def run_update
    if @order.update status_params
      OrderMailer.status(@order).deliver_later
    else
      raise StandardError
    end
  end

  def approve_or_reject_order
    if @order.status == "pending"
      run_update
    else
      raise StandardError
    end
  end

  def processing_order
    if @order.status == "approved"
      run_update
    else
      raise StandardError
    end
  end
  def finished_order
    if @order.status == "processing"
      run_update
    else
      raise StandardError
    end
  end

  def status_params
    params.require(:order).permit(:status)
  end

  def find_order
    @order = find_object Order, params[:id]
  end
end
