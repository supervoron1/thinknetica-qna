FactoryBot.define do
  factory :answer do
    body { "Answer_body" }
    question
    user

    trait :invalid do
      body { nil }
    end
  end
end
