# frozen_string_literal: true

module Employee
  class SpaController < ::Employee::ApplicationController
    def main
      set_props
    end

    def not_found
      render :main, status: 404
    end

    def server_error
      render :main, status: 500
    end

    def no_routing
      render :main, status: 404
    end

    private

    def set_props
      @props = {
        environment: ::Rails.env,
        client_version: self.class.current_version
      }
    end
  end
end
