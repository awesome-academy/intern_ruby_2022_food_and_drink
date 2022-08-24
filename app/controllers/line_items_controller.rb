class LineItemsController < ApplicationController
  layout "dashboard"
  def create
    check_currrent_cart
    @line_item.save
    redirect_to carts_path
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to carts_path
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity -= 1 if @line_item.quantity > 1
    @line_item.save
    redirect_to carts_path
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to carts_path
  end

  private
  def line_item_params
    params.require(:line_item).permit(:quantity, :product_attribute_id, :cart_id)
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
