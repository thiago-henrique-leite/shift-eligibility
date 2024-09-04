FactoryBot.define do
  factory :facility do
    name { 'name' }
    is_active { true }

    trait :inactive do
      is_active { false }
    end
  end
end
