class ShiftRepository
  def self.shifts_for_facilities(worker, facility_ids, start_date, end_date)
    Shift
      .active
      .unclaimed
      .for_facilities(facility_ids)
      .for_date_range(start_date, end_date)
      .for_profession(worker.profession)
      .for_available_worker(worker, start_date, end_date)
      .distinct
  end

  def self.facilities_for_worker(worker)
    Facility
      .active
      .for_available_worker(worker)
      .distinct
      .pluck(:id)
  end
end
