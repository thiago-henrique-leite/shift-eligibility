class WorkersController < ApplicationController
  def shifts
    render json: Kaminari.paginate_array(fetch_shifts).page(page).per(per_page)
  end

  private

  def end_date
    params[:end_date] || '2100-01-01'
  end

  def fetch_shifts
    cache_key = "worker_#{worker.id}_shifts_#{start_date}_#{end_date}_page_#{page}_per_page_#{per_page}"

    return Rails.cache.read(cache_key) if Rails.cache.exist?(cache_key)

    shifts = ShiftEligibilityService.new(worker.id, start_date, end_date).eligible_shifts

    Rails.cache.write(cache_key, shifts, expires_in: 5.minutes)

    shifts
  end

  def start_date
    params[:start_date] || '1900-01-01'
  end

  def worker
    @worker = Worker.find(params[:worker_id])
  end
end
