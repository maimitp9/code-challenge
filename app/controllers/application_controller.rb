# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # rescue_from Exception, with: :render_500
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from ActionView::MissingTemplate, with: :render_404

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    return nil unless logged_in?

    @current_user ||= User.find(session[:user_id])
  end

  def abort_if_not_authenticate!
    return if logged_in?

    redirect_to root_url
  end

  def redirect_to_main_if_authenticated!
    if logged_in? && current_user.present?
      redirect_to admin_dashboard_url if current_user.admin?
      redirect_to employee_dashboard_url if current_user.employee?
    end
  end

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

  def render_404(exception = nil)
    logger.info("Rendering 404 with exception: #{e.message}") if e

    render file: Rails.root.join('public', '404.html'), status: 404, layout: false,
           content_type: 'text/html'
  end

  def render_500(exception)
    logger.error(exception)

    render file: Rails.root.join('public', '500.html'), status: 500, layout: false,
           content_type: 'text/html'
  end
end
