# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Make admin
User.create!(
  name: "admin",
  phone: "0123456789",
  email: "admin@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  role: 2,
  status: 1
)
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  phone = Faker::Number.number(digits: 8)
  User.create!(
    name: name,
    email: email,
    phone: phone,
    password: password,
    password_confirmation: password,
    role: 1,
    status: 1
  )
end
users = User.order(:created_at)
address = Faker::Address.city
users.each { |user| user.addresses.create!(
  name: address,
  types: rand(2) == 1 ? 0 : 1
  )
}

Size.create!(name: "S")
Size.create!(name: "M")
Size.create!(name: "L")
Size.create!(name: "XL")

6.times do |n|
  name = Faker::Commerce.brand
  Category.create!(
    name: name,
    status: 0
  )
end

20.times do |n|
  name = Faker::Commerce.product_name
  description = Faker::Lorem.sentence(word_count: 100)
  Product.create!(
    name: name,
    description: description,
    status: 1,
    category_id: Faker::Number.between(from: 1, to: 6)
  )
end

Product.all.each { |pro| pro.product_attributes.create!(
  price: 20,
  quantity: 100,
  size_id: Faker::Number.between(from: 1, to: 4)
  )
}

Product.all.each { |pro| pro.product_images.create!(
  image: Faker::LoremFlickr.image
  )
}
