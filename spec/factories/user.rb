FactoryBot.define do
  factory :user, aliases: [:seller] do
    first_name { "Mike" }
    last_name { "Smith" }
    mobile_number { Faker::PhoneNumber.unique.cell_phone_in_e164 }
    sequence(:username) { |num| "mike.smith#{num}@example.org" }
    password { "mikeymike123" }

    %i(seller buyer).each do |key|
      trait key do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        mobile_number { Faker::PhoneNumber.unique.cell_phone_in_e164 }
        username { Faker::Internet.email }
        password { "Password123" }
      end
    end
  end
end
