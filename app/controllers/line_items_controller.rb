class LineItemsController < ApplicationController
  layout "dashboard"
  before_action :find_line_item, only: %i(change_quantity destroy)

  def create
    check_currrent_cart
    if @line_item.save
      flash[:success] = t ".success_create"
    else
      flash[:danger] = t ".err_create"
    end
    redirect_to carts_path
  end

  def change_quantity
    @line_item.quantity = @line_item.quantity.send(params[:operator], 1)
    if @line_item.save
      flash[:success] = t ".success_qty"
    else
      flash[:danger] = t ".err_qty"
    end
    redirect_to carts_path
  end

  def destroy
    if @line_item.destroy
      flash[:success] = t ".success_delete_line"
    else
      flash[:danger] = t ".err_delete_line"
    end
    redirect_to carts_path
  end

  private
  def line_item_params
    params.require(:line_item).permit(:quantity, :product_attribute_id, :cart_id)
  end

  def find_line_item
    @line_item = LineItem.find_by(params[:id])
    return if @line_item

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def check_currrent_cart
    chosen_product = ProductAttribute.find(params[:product_attribute_id])
    qty = params[:line_item][:quantity].to_i
    current_cart = @current_cart
    if current_cart.product_attributes.include?(chosen_product)
      @line_item = current_cart.line_items.find_by(product_attribute_id: chosen_product)
      @line_item.quantity += qty
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.quantity = qty
      @line_item.product_attribute = chosen_product
    end
  end
end
