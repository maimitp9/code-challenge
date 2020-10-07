# frozen_string_literal: true

module Admin
  module Api
    class SessionsController < ::Admin::Api::ApplicationController
      def create
        form = ::Admin::Sessions::NewForm.new(session_params)
        render_active_model_errors(form) and return if form.invalid?

        user = User.find_by(email: form.email).try(:authenticate, form.password)

        unless user
          form.errors.add(:base, :authentication_failed)
          render_active_model_errors(form) and return
        end

        reset_session
        session[:user_id] = user.id

        head :created, location: determine_redirect_target(user)
      end

      def destroy
        reset_session

        head :no_content
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end

      def determine_redirect_target(user)
        if user.admin?
          admin_dashboard_url
        else
          employee_dashboard_url
        end
      end
    end
  end
end
