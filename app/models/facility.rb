class Facility < ApplicationRecord
  self.table_name = 'Facility'

  has_many :facility_requirements
  has_many :documents, through: :facility_requirements
  has_many :shifts

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }
end
