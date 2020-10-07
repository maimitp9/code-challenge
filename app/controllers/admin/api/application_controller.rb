# frozen_string_literal: true

module Admin
  module Api
    class ApplicationController < ::Admin::ApplicationController
      skip_before_action :verify_authenticity_token
    end
  end
end
