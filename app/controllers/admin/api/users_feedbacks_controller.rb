# frozen_string_literal: true

module Admin
  module Api
    class UsersFeedbacksController < ::Admin::Api::ApplicationController
      def create
        users_feedback = UsersFeedback.new(users_feedback_params)
        render_active_model_errors(users_feedback) and return if users_feedback.invalid?

        users_feedback.save!

        render json: users_feedback, status: :created
      end

      def update; end

      private

      def users_feedback_params
        params.require(:users_feedback).permit(:user_id, :feedback_id, :reviewer_id)
      end
    end
  end
end
