FactoryBot.define do
  factory :worker do
    name { 'name' }
    profession { 'RN' }
    is_active { true }

    trait :inactive do
      is_active { false }
    end
  end
end
