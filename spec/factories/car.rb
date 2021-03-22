FactoryBot.define do
  factory :car do
    make do
      car_make = Faker::Vehicle.make
      car_make = "Chevrolet" if car_make == "Chevy"
      car_make
    end
    model { Faker::Vehicle.model }
    year { Faker::Vehicle.year }
    condition { Car.conditions.keys.sample }
    price { Faker::Commerce.price(range: 1_000..100_000) }
    association :seller, strategy: :build
  end
end
