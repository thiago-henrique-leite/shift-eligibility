FactoryBot.define do
  factory :document do
    name { 'name' }
    is_active { true }

    trait :inactive do
      is_active { false }
    end
  end
end
