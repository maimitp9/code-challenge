# frozen_string_literal: true

module Employee
  module Api
    class FeedbacksController < ::Employee::Api::ApplicationController
      def index
        feedbacks = Feedback.includes(:users_feedbacks, :questions)
                            .where(
                              users_feedbacks: {
                                reviewer_id: current_user.id
                              }
                            )

        render json: feedbacks, status: :ok,
               scope: { questions: true, users_feedbacks: true, user: true,
                        reviewer: true },
               include: { questions: [], users_feedbacks: %i[user reviewer] }
      end

      def show
        feedback = Feedback.includes(
          feedbacks_questions: [:question],
          users_feedbacks: %i[user reviewer]
        ).where(
          users_feedbacks: {
            feedback_id: params[:id],
            reviewer_id: current_user.id
          }
        ).first

        render json: feedback, status: :ok,
               scope: { feedbacks_questions: true, question: true,
                        users_feedbacks: true, user: true, reviewer: true },
               include: { feedbacks_questions: [:question],
                          users_feedbacks: %i[user reviewer] }
      end
    end
  end
end
