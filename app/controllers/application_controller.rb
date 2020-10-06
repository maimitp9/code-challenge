# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  class << self
    def current_version
      @current_version ||= `git show -s --format=%ct HEAD`.chomp.to_i
    end
  end
end
