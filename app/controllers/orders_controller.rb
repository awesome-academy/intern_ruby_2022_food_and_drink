class OrdersController < ApplicationController
  layout "dashboard"
  before_action :logged_in_user
  before_action :find_order, only: %i(show change_status)

  def index
    @pagy, @orders = pagy current_user.orders.order_latest
  end

  def new
    @cart = @current_cart
    if @cart.line_items.empty?
      redirect_to root_path
      return
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      insert_order_detail @order
      send_mail @order, params[:email]
      flash[:success] = t ".order_success"
      redirect_to root_path
    else
      @cart = @current_cart
      flash[:error] = t ".order_fail"
      render :new
    end
  end

  def show; end

  def change_status
    if @order.update(status: params[:status])
      CancelOrderMailer.reject_order(@order, params[:email]).deliver_now
      flash[:success] = t ".reject_success"
    else
      flash[:error] = t ".reject_fail"
    end
    redirect_to @order
  end
  private

  def order_params
    params.require(:order).permit(:total, :status, :phone, :user_id, :address_id, :note)
  end

  def insert_order_detail order_insert
    @current_cart.line_items.each do |line_item|
      order_insert.order_details.create!(
        product_attribute_id: line_item.product_attribute.id,
        quantity:   line_item.quantity,
        price: line_item.product_attribute.price
      )
    end
  end

  def send_mail order_insert, order_email
    OrderReceivedMailer.order_received(order_insert, order_email).deliver_now
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def find_order
    @order = Order.find(params[:id])
    return if @order

    flash[:danger] = t ".not_found"
    redirect_to orders_path
  end
end
