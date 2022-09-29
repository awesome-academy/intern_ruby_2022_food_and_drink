class DashboardController < ApplicationController
  include AuthHelper
  layout "dashboard"
  before_action :find_product, only: :show
  skip_before_action :is_admin?
  def index
    @pagy, @products = pagy Product.latest_product,
                            items: Settings.products.item_product
    @categories = Category.all
    @sizes = Size.all
    render "pages/products_landing"
  end

  def show
    render "pages/show"
  end

  private

  def find_product
    @product = find_object Product, params[:id]
  end
end
