module Api
  module V1
    class WorkersController < ApplicationController
      def shifts
        render json: Kaminari.paginate_array(available_shifts).page(page).per(per_page)
      end

      private

      def available_shifts
        cache_key = "worker_#{worker_id}_shifts_#{start_date}_#{end_date}_page_#{page}_count_#{per_page}"

        Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
          ShiftEligibilityService.eligible_shifts_for_worker(worker_id, start_date, end_date)
        end
      end

      def end_date
        params[:end_date]
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
