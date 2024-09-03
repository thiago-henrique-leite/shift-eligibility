class Facility < ApplicationRecord
  self.table_name = 'Facility'

  has_many :facility_requirements, dependent: :destroy
  has_many :documents, through: :facility_requirements
  has_many :shifts, dependent: :destroy

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }

  scope :for_available_worker, lambda { |worker|
    active.where(
      'EXISTS (
        SELECT 1
        FROM "FacilityRequirement"
        WHERE facility_id = "Facility".id
        GROUP BY facility_id
        HAVING array_agg(DISTINCT document_id) @> (
          SELECT array_agg(DISTINCT document_id)
          FROM "DocumentWorker"
          WHERE worker_id = ?
          AND document_id IN (
            SELECT id
            FROM "Document"
            WHERE is_active = TRUE
          )
        )
      )', worker.id
    ).distinct.pluck(:id)
  }
end
