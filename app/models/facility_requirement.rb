class FacilityRequirement < ApplicationRecord
  self.table_name = 'FacilityRequirement'

  belongs_to :facility
  belongs_to :requirement
end
