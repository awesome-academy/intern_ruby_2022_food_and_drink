FactoryBot.define do
  factory :product_attribute do
    price { rand(1000...10000)}
    quantity { rand(1...1000) }
    product { FactoryBot.create :product }
    size { FactoryBot.create :size }
  end
end
