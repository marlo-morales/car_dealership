FactoryBot.define do
  factory :user, aliases: [:seller] do
    first_name { "Mike" }
    last_name { "Smith" }
    mobile_number { "1234567890" }
    username { "mike.smith" }
    password { "Password123" }
  end
end
