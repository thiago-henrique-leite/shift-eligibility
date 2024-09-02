class ShiftRepository
  def self.available_shifts_for_facility(worker, facility_ids, start_date, end_date)
    Shift
      .joins(:facility)
      .active
      .unclaimed
      .for_facilities(facility_ids)
      .for_date_range(start_date, end_date)
      .for_profession(worker.profession)
      .where.not(
        'EXISTS (
          SELECT 1
          FROM "Shift" AS shifts
          WHERE shifts.worker_id = ?
          AND shifts.start < ?
          AND shifts.ends_at > ?
        )', worker.id, end_date, start_date
      )
  end

  def self.available_facility_ids(worker)
    Facility
      .active
      .joins(:facility_requirements)
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
        )', worker.documents.active.distinct.pluck(:id)
      ).distinct.pluck(:id)
  end
end
