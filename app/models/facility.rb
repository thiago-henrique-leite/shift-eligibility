class Facility < ApplicationRecord
  self.table_name = 'Facility'

  has_many :facility_requirements, dependent: :destroy
  has_many :documents, through: :facility_requirements
  has_many :shifts, dependent: :destroy

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }

  scope :for_available_worker, ->(worker) {
    document_ids = worker.documents.active.distinct.pluck(:id)

    .where.not(
      'EXISTS (
        SELECT 1
        FROM "FacilityRequirement" AS fr
        WHERE fr.facility_id = "Facility".id
        AND fr.document_id = ALL (
          SELECT DISTINCT d.id
          FROM "Document" AS d
          WHERE d.id IN (?)
        )
      )', document_ids
    )
  }
end
