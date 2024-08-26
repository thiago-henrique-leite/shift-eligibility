FactoryBot.define do
  factory :facility_requirement do
    association :facility
    association :document
  end
end
