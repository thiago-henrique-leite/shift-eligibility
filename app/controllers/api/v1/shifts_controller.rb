module Api
  module V1
    class ShiftsController < ApplicationController
      include ExceptionHandler

      def index
        render json: available_shifts.page(page).per(per_page).group_by(&:start)
      end

      private

      def available_shifts
        cache_key = "shifts/#{worker_id}/#{facility_id}/#{start_date}/#{end_date}/#{page}/#{per_page}"

        Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
          ShiftEligibilityService.new(worker_id, facility_id, start_date, end_date).shifts_by_worker_and_facility
        end
      end

      def end_date
        params[:end_date]
      end

      def facility_id
        params[:facility_id]
      end

      def start_date
        params[:start_date]
      end

      def worker_id
        params[:worker_id]
      end
    end
  end
end
