class Document < ApplicationRecord
  self.table_name = 'Document'

  has_many :facility_requirements
  has_many :facilities, through: :facility_requirements
  has_many :document_workers
  has_many :workers, through: :document_workers

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }
end
