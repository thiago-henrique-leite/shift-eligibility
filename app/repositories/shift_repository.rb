class ShiftRepository
  def self.shifts_for_worker(worker, start_date, end_date)
    Shift
      .active
      .unclaimed
      .for_facilities(Facility.for_available_worker(worker))
      .for_date_range(start_date, end_date)
      .for_profession(worker.profession)
      .for_available_worker(worker, start_date, end_date)
      .distinct
  end
end
