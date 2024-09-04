class Facility < ApplicationRecord
  self.table_name = 'Facility'

  has_many :facility_requirements, dependent: :destroy
  has_many :documents, -> { active }, through: :facility_requirements
  has_many :shifts, dependent: :destroy

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }
end
