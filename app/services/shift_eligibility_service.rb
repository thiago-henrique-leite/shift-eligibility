class ShiftEligibilityService
  def initialize(worker_id, start_date, end_date)
    @worker_id = worker_id
    @start_date = start_date
    @end_date = end_date
  end

  def eligible_shifts_for_worker
    validate!

    return [] unless worker.is_active?

    ShiftRepository.shifts_for_worker(worker, start_date, end_date)
  end

  private

  attr_reader :worker_id, :start_date, :end_date

  def validate!
    raise ArgumentError, 'worker_id invalid' if worker.nil?
    raise ArgumentError, 'start_date is required' if start_date.nil?
    raise ArgumentError, 'end_date is required' if end_date.nil?
  end

  def worker
    @worker ||= Worker.find_by(id: worker_id)
  end
end
