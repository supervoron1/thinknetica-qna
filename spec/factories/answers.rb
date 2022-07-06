FactoryBot.define do
  factory :answer do
    body { "MyText" }
    references { "" }

    trait :invalid do
      body { nil }
    end
  end
end
