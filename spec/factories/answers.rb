FactoryBot.define do
  factory :answer do
    body { "Answer_body" }

    trait :invalid do
      body { nil }
    end
  end
end
