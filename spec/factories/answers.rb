FactoryBot.define do
  factory :answer do
    body { "Answer_body" }
    question { create(:question) }
    user { create(:user) }

    trait :invalid do
      body { nil }
    end
  end
end
