# frozen_string_literal: true

module Employee
  module Api
    class ApplicationController < ::Employee::ApplicationController
      skip_before_action :verify_authenticity_token
    end
  end
end
