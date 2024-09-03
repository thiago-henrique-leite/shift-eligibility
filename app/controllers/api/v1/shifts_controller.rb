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
        cache_key = search_params.map { |key, value| "#{key}_#{value}" }.join('_')

        Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
          ShiftEligibilityService.new(**search_params).eligible_shifts_for_worker
        end
      end

      def search_params
        params.permit(
          :end_date,
          :start_date,
          :worker_id
        ).to_h.symbolize_keys
      end
    end
  end
end
