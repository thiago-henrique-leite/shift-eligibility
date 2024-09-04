module ExceptionHandler
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      rescue_from StandardError do |error|
        render json: { message: error.message }, status: :internal_server_error
      end

      rescue_from ActiveRecord::RecordInvalid do |error|
        render json: { message: error.message }, status: :unprocessable_entity
      end

      rescue_from ActiveRecord::RecordNotFound do |error|
        render json: { message: error.message }, status: :not_found
      end

      rescue_from ArgumentError do |error|
        render json: { message: error.message }, status: :bad_request
      end
    end
  end
end
