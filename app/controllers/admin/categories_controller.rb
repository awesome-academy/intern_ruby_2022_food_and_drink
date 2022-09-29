class Admin::CategoriesController < ApplicationController
  before_action :find_category, except: %i(new create index)
  before_action :get_all_category, only: %i(index destroy)

  def index
    @category = Category.new
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t ".alert_success_create"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t ".alert_err_create"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = t ".alert_success_update"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".alert_err_update"
      render :edit
    end
  end

  def destroy
    raise StandardError unless check_orders_product_in_category?

    message, status = @category.destroy ? [t(".alert_success_destroy"), 200] : [t(".alert_err_destroy"), 500]
    render json: {message: message, status: status}
  end

  private

  def check_orders_product_in_category?
    count_order = []
    @category.products.each do |f|
      next if f.order_details.count.zero?

      count_order << f.order_details.count
      break if count_order.present?
    end

    count_order.blank?
  end

  def category_params
    params.require(:category).permit Category::ATTR_CATE
  end

  def find_category
    @category = find_object Category, params[:id]
  end

  def get_all_category
    @pagy, @categories = pagy Category.latest_category,
                              items: Settings.category.item_category
  end
end
