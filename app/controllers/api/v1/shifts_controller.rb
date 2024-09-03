module Api
  module V1
    class ShiftsController < ApplicationController
      def index
        render json: pagination(available_shifts)
      rescue ArgumentError => e
        render json: { error: e.message }, status: :bad_request
      end

      private

      def available_shifts
        cache_key = "shifts/#{worker_id}/#{start_date}/#{end_date}/#{page}/#{per_page}"

        Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
          ShiftEligibilityService.new(worker_id, start_date, end_date).eligible_shifts_for_worker
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
