class ShiftEligibilityService
  def initialize(worker_id, facility_id, start_date, end_date)
    @worker_id = worker_id
    @facility_id = facility_id
    @start_date = start_date
    @end_date = end_date
  end

  def shifts_by_worker_and_facility
    validate!

    ShiftRepository.shifts_for_worker_and_facility(worker, facility, start_date, end_date)
  end

  private

  attr_reader :worker_id, :facility_id, :start_date, :end_date

  def validate!
    raise ArgumentError, 'worker not found or inactive' if worker.blank?
    raise ArgumentError, 'facility not found or inactive' if facility.blank?
    raise ArgumentError, 'start_date is required' if start_date.blank?
    raise ArgumentError, 'end_date is required' if end_date.blank?
  end

  def worker
    @worker ||= Worker.active.find_by(id: worker_id)
  end

  def facility
    @facility ||= Facility.active.find_by(id: facility_id)
  end
end
