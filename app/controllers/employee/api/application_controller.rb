# frozen_string_literal: true

module Employee
  module Api
    class ApplicationController < ::Employee::ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :abort_if_not_authenticate!

      rescue_from ::StandardError, with: :render_500
      rescue_from ::ActiveRecord::RecordNotFound, with: :render_404
      rescue_from ::ActionController::ParameterMissing, with: :handle_invalid_request_error

      def handle_invalid_request_error(exception)
        logger.info("Rendering 400 with exception: #{exception.message}")

        error = Error.new(code: ::ErrorCode::VALIDATION_OTHERS,
                          message: 'Invalid request')
        render_errors(error, status: 400)
      end

      def render_404(exception = nil)
        logger.info("Rendering 404 with exception: #{exception.message}") if e

        error = Error.new(
          code: ErrorCode::NO_ROUTE_MATCH_OR_NOT_FOUND,
          message: 'Not found'
        )

        render_errors(error, status: 404)
      end

      def render_500(exception)
        logger.error(exception)

        error = ::Site::Api::Error.new(code: ::ErrorCode::UNEXPECTED_ERROR,
                                       message: 'Unexpected server error')
        render_errors(error, status: 500)
      end
    end
  end
end
