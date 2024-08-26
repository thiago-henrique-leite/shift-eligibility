class FacilityRequirement < ApplicationRecord
  self.table_name = 'FacilityRequirement'

  belongs_to :document
  belongs_to :facility
end
