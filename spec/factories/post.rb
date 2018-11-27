FactoryBot.define do
  factory :post do
    title { "RSpec Post Title" }
    body { "This is an example post" }
    author
  end
end
