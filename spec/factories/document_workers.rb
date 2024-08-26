FactoryBot.define do
  factory :document_worker do
    association :document
    association :worker
  end
end
