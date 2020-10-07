# frozen_string_literal: true

module Admin
  class SpaController < ::Admin::ApplicationController
    skip_before_action :verify_authenticity_token

    before_action :redirect_to_main_if_authenticated!, only: :login
    before_action :abort_if_not_authenticate!, only: :main
    before_action :abort_if_employee!, except: :login

    def login
      set_props

      render :main
    end

    def main
      set_props
    end

    def not_found
      set_props

      render :main, status: 404
    end

    def server_error
      set_props

      render :main, status: 500
    end

    def no_routing
      set_props

      render :main, status: 404
    end

    private

    def set_props
      @props = {
        environment: ::Rails.env,
        client_version: self.class.current_version,
        current_user: current_user
      }
    end

    def abort_if_employee!
      redirect_to employee_dashboard_url if current_user.employee?
    end
  end
end
