# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def render_active_model_errors(model)
    converted_errors = ::ActiveModelErrorsConverter.convert(model.errors, model.class)
    render_errors(converted_errors, status: 400)
  end

  class << self
    def current_version
      @current_version ||= `git show -s --format=%ct HEAD`.chomp.to_i
    end
  end

  private

  # @param [Admin::Api::Error, Array<Admin::Api::Error>] errors
  # @param [Integer] status
  def render_errors(errors, status:)
    render json: { errors: Array(errors) }, status: status
  end
end
