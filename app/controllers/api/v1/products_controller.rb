class Api::V1::ProductsController < Api::V1::BaseApiController
  skip_before_action :verify_authenticity_token, :authenticate, only: %i(create update destroy)
  before_action :find_product, only: %i(show update destroy)

  def index
    @pagy, @products = pagy Product.latest_product, items: Settings.const.paginate
    render json: ProductSerializer.new(@products).serializable_hash
  end

  def create
    @product = Product.new product_params
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: ProductSerializer.new(@product).serializable_hash
  end

  def update
    if @product.update product_params
      render json: {
        product: ProductSerializer.new(@product).serializable_hash,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def destroy
    if @product.destroy
      render json: {
        product: @product.attributes,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  private

  def product_params
    params.require(:product).permit Product::PARAMS_PRODUCTS
  end

  def find_product
    @product = find_object Product, params[:id]
  end
end
