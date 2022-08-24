class CartsController < ApplicationController
  layout "dashboard"
  def index
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to dashboard_path
  end
end
