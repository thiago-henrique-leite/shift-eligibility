class ShiftRepository
  class << self
    def shifts_for_worker(worker, facility, start_date, end_date)
      Shift
        .active
        .unclaimed
        .with_facility(facility.id)
        .with_date_range(start_date, end_date)
        .with_profession(worker.profession)
        .with_availability_for_worker(worker, start_date, end_date)
        .distinct
        .group_by(&:start)
    end
  end
end
