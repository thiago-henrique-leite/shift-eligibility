class Facility < ApplicationRecord
  self.table_name = 'Facility'

  has_many :facility_requirements, dependent: :destroy
  has_many :documents, through: :facility_requirements
  has_many :shifts, dependent: :destroy

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }

  scope :matching_worker_documents, ->(worker) {
    active
      .joins(:facility_requirements)
      .group('Facility.id')
      .having('array_agg(DISTINCT document_id) @> ARRAY[?]', worker.document_ids.presence || [0])
      .pluck(:id)
  }
end
