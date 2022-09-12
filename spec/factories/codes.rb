FactoryBot.define do
  factory :code do
    code { "123" }

    trait :invalid do
      code { nil }
    end  
  end
end
