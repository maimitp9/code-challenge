# frozen_string_literal: true

module Admin
  module Api
    class FeedbacksController < ::Admin::Api::ApplicationController
      def index
        feedbacks = Feedback.includes(users_feedbacks: [feedbacks_questions_answers_by_user: %i[user question answer]])

        render json: feedbacks, status: :ok,
               scope: {
                 feedbacks: true,
                 users_feedbacks: true,
                 feedbacks_questions_answers_by_user: true,
                 user: true,
                 question: true,
                 answer: true
               },
               include: {
                 feedbacks: [],
                 users_feedbacks: [by_user: %i[user question answer]]
               }
      end

      def create; end

      def update; end
    end
  end
end
