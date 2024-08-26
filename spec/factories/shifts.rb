FactoryBot.define do
  factory :shift do
    association :facility
    association :worker

    start_time { 1.hour.since }
    end_time { 3.hours.since }
  end
end
