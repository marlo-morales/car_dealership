# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_cars_for(user)
  return if user.cars.present?

  Array.new(rand(10..50)) do |num|
    print "."
    make = Faker::Vehicle.make
    user.cars.create(
      make: make, model: Faker::Vehicle.model(make_of_model: make), year: Faker::Vehicle.year,
      condition: Car.conditions.keys.sample,
      price: Faker::Commerce.price(range: 1_000..100_000)
    )
  end
  print " ✓\n"
end

puts "== Creating Iron Mike =="
user1 = User.find_or_initialize_by(username: "mike@example.org").tap do |u|
  u.first_name = "Iron"
  u.last_name = "Mike"
  u.password = "mikeymike123"
  u.mobile_number = Faker::PhoneNumber.unique.cell_phone_in_e164
  u.save
end

puts "== Creating John Doe =="
user2 = User.find_or_initialize_by(username: "john.doe@example.org").tap do |u|
  u.first_name = "John"
  u.last_name = "Doe"
  u.password = "Password123"
  u.mobile_number = Faker::PhoneNumber.unique.cell_phone_in_e164
  u.save
end

puts "== Listing cars for John Doe =="
create_cars_for(user2)

puts "== Creating Jane Smith =="
user3 = User.find_or_initialize_by(username: "jane.smith@example.org").tap do |u|
  u.first_name = "Jane"
  u.last_name = "Smith"
  u.password = "Password123"
  u.mobile_number = Faker::PhoneNumber.unique.cell_phone_in_e164
  u.save
end

puts "== Listing cars for Jane Smith =="
create_cars_for(user3)
