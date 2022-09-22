module Admin::ProductsHelper
  def display_image product
    if product.product_images.present?
      product.product_images.first.image_url
    else
      image_url("images/product_image_default.jpg")
    end
  end
end
