require_relative '../repositories/shift_repository'

class ShiftEligibilityService
  def initialize(worker_id, start_date, end_date)
    @worker_id = worker_id
    @start_date = start_date
    @end_date = end_date
  end

  def eligible_shifts
    return [] unless worker.is_active

    ::ShiftRepository.available_shifts_for_facility(worker, facility_ids, start_date, end_date)
  end

  private

  attr_reader :worker_id, :start_date, :end_date

  def worker
    @worker ||= Worker.find(worker_id)
  end

  def facility_ids
    @facility_ids ||= ::ShiftRepository.available_facility_ids(worker)
  end
end
