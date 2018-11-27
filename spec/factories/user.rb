FactoryBot.define do
  factory :user, aliases: [:author] do
    first_name { "John" }
    last_name { "Smith" }
    username { "john.smith" }
    password { "Password123" }
  end
end
