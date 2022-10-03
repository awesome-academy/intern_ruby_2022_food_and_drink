class Api::V1::CategoriesController < Api::V1::BaseApiController
  skip_before_action :verify_authenticity_token, :authenticate, only: %i(create update destroy)
  before_action :find_category, only: %i(show update destroy)
  before_action :check_orders_product_in_category?, only: %i(destroy)

  def index
    @pagy, @categories = pagy Category.latest_category, items: Settings.const.paginate
    render json: @categories
  end

  def create
    @category = Category.new category_params
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @category.attributes
  end

  def update
    if @category.update category_params
      render json: {
        category: @category.attributes,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def destroy
    if @category.destroy
      render json: {
        category: @category.attributes,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = find_object Category, params[:id]
  end

  def check_orders_product_in_category?
    count_order = []
    @category.products.each do |f|
      next if f.order_details.count.zero?

      count_order << f.order_details.count
      break if count_order.present?
    end

    return if count_order.present?

    render json: {message: I18n.t("fail")}
  end
end
