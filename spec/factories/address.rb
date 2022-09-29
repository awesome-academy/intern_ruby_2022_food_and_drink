FactoryBot.define do
  factory :address do
    name { Faker::Name.unique.name}
    types { rand(0..1) }
    user { FactoryBot.create :user }
  end
end
