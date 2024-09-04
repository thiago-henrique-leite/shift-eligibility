module Api
  module V1
    module Schemas
      module Shift
        def self.schema
          {
            shifts: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  start: { type: :string, format: 'date-time' },
                  ends_at: { type: :string, format: 'date-time' },
                  profession: { type: :string },
                  is_deleted: { type: :boolean },
                  facility_id: { type: :integer },
                  worker_id: { type: :integer }
                },
                required: %w[
                  id
                  start
                  ends_at
                  profession
                  is_deleted
                  facility_id
                  worker_id
                ]
              }
            }
          }
        end
      end
    end
  end
end
