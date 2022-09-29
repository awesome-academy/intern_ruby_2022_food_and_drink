FactoryBot.define do
  factory :order_detail do
    price { rand(0...100) }
    quantity { rand(0...100) }
    product_attribute { FactoryBot.create :product_attributes }
    order { FactoryBot.create :order }
  end
end
