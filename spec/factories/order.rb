FactoryBot.define do
  factory :order do
    total { rand(0...100) }
    note { Faker::Lorem.paragraph_by_chars(number: 210)}
    status { rand(0...3) }
    phone { Faker::PhoneNumber.subscriber_number(length: 10) }
    user { FactoryBot.create :user }
    address { FactoryBot.create :address }
  end
end
