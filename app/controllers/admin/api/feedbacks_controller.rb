# frozen_string_literal: true

module Admin
  module Api
    class FeedbacksController < ::Admin::Api::ApplicationController
      def index
        feedbacks = Feedback.includes(:questions, users_feedbacks: %i[user reviewer])

        render json: feedbacks, status: :ok,
               scope: { questions: true, users_feedbacks: true, user: true, reviewer: true },
               include: { questions: [], users_feedbacks: %i[user reviewer] }
      end

      def show
        feedback = Feedback.includes(:questions, users_feedbacks: %i[user reviewer]).find(params[:id])

        render json: feedback, status: :ok,
               scope: { questions: true, users_feedbacks: true, user: true, reviewer: true },
               include: { questions: [], users_feedbacks: %i[user reviewer] }
      end

      def create
        form = Admin::Api::Feedbacks::NewForm.new(feedback_params)
        render_active_model_errors(form) and return if form.invalid?

        form.persist!

        render json: form, status: :created
      end

      def update; end

      private

      def feedback_params
        params.require(:feedback).permit(:title, :status, questions: [:text])
      end
    end
  end
end
