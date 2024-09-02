class ShiftRepository
  def self.available_shifts_for_facility(worker, facility_ids, start_date, end_date)
    Shift
      .joins(:facility)
      .active
      .unclaimed
      .for_facilities(facility_ids)
      .for_date_range(start_date, end_date)
      .for_profession(worker.profession)
      .for_available_worker(worker, start_date, end_date)
      .distinct
  end

  def self.available_facility_ids(worker)
    Facility
      .active
      .joins(:facility_requirements)
      .for_available_worker(worker)
      .distinct
      .pluck(:id)
  end
end
