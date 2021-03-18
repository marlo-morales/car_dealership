FactoryBot.define do
  factory :car do
    make { "Ford" }
    model { "Shelby" }
    year { 2021 }
    condition { :excellent }
    price { 99_999 }
    association :seller, strategy: :build
  end
end
