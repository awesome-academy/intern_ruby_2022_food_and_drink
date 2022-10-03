class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
  attribute :details do |product|
    product.product_attributes.select("id, price, size_id")
  end
  attribute :images do |product|
    product.product_images.select("id, image")
  end
end
