# frozen_string_literal: true

module Admin
  module Api
    class FeedbacksController < ::Admin::Api::ApplicationController
      before_action :set_feedback, only: :show

      def index
        feedbacks = Feedback.includes(:questions)

        render json: feedbacks, status: :ok,
               scope: { questions: true }
        # feedbacks = Feedback.includes(users_feedbacks: [feedbacks_questions_answers_by_user: %i[user question answer]])

        # render json: feedbacks, status: :ok,
        #        scope: {
        #          feedbacks: true,
        #          users_feedbacks: true,
        #          feedbacks_questions_answers_by_user: true,
        #          user: true,
        #          question: true,
        #          answer: true
        #        },
        #        include: {
        #          feedbacks: [],
        #          users_feedbacks: [by_user: %i[user question answer]]
        #        }
      end

      def show
        # feedback = Feedback.includes(:questions)

        render json: @feedback, status: :ok,
               scope: { questions: true },
               include: [:questions]
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

      def set_feedback
        @feedback = Feedback.find(params[:id])
      end
    end
  end
end
