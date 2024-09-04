FactoryBot.define do
  factory :shift do
    association :facility
    association :worker

    start { 1.hour.since }
    ends_at { 3.hours.since }
    is_deleted { false }
    profession { 'CNA' }

    trait :inactive do
      is_deleted { true }
    end

    trait :unclaimed do
      worker { nil }
    end
  end
end
