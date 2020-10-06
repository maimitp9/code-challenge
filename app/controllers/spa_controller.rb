# frozen_string_literal: true

# Single page applicaition controller
class SpaController < ApplicationController
  def index
    set_props
  end

  def not_found
    render :index, status: 404
  end

  def server_error
    render :index, status: 500
  end

  def no_routing
    render :index, status: 404
  end

  private

  def set_props
    @props = {
      environment: ::Rails.env,
      client_version: self.class.current_version
    }
  end
end
