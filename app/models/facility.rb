class Facility < ApplicationRecord
  self.table_name = 'Facility'

  validates :name, presence: true
end
