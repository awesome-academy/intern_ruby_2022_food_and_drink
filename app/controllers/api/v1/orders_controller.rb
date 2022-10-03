class Api::V1::OrdersController < Api::V1::BaseApiController
  skip_before_action :is_admin?, except: %i(update_status)
  skip_before_action :verify_authenticity_token, :authenticate, only: %i(create update update_status destroy)
  before_action :find_order, :correct_user_order, only: %i(show update destroy)
  before_action :find_order, only: %i(update_status)

  def index
    @pagy, @orders = pagy Order.order(id: :desc), items: Settings.const.paginate
    render json: OrderSerializer.new(@orders).serializable_hash
  end

  def create
    total = order_params[:order_details_attributes].values.reduce(0) do |sum, v|
      sum + (v["price"].to_i * v["quantity"].to_i)
    end

    @order = Order.new order_params.merge(total: total)
    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: OrderSerializer.new(@order).serializable_hash
  end

  def update
    if @order.update order_params
      render json: {
        order: OrderSerializer.new(@order).serializable_hash,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def update_status
    case status_params[:status]
    when "rejected", "approved"
      approve_or_reject_order
    when "processing"
      processing_order
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def destroy
    if @order.destroy
      render json: {
        order: @order.attributes,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  private

  def order_params
    params.require(:order).permit(:note, :phone, :user_id, :address_id,
                                  order_details_attributes: [:id, :price, :quantity, :product_attribute_id])
  end

  def status_params
    params.require(:order).permit(:status)
  end

  def run_update
    if @order.update status_params
      OrderMailer.status(@order).deliver_now
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def approve_or_reject_order
    if @order.pending?
      run_update
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def processing_order
    if @order.approved?
      run_update
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def find_order
    @order = find_object Order, params[:id]
  end

  def correct_user_order
    return if current_user.present? && (@order.user_id == current_user.id || is_admin?)

    render json: {error: I18n.t("unauthorized")}, status: :unauthorized
  end
end
