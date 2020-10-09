# frozen_string_literal: true

module Employee
  module Api
    class FeedbacksQuestionsAnswersController < ::Employee::Api::ApplicationController
      def create
        form = Employee::Api::FeedbacksQuestionsAnswers::NewForm.new(
          feedbacks_questions_answers_params
        )
        render_active_model_errors(form) && return if form.invalid?

        form.persist!
        head :created
      end

      private

      def feedbacks_questions_answers_params
        params.require(:feedbacks_questions_answer).permit(
          :users_feedbacks_id, :user_id, :reviewer_id,
          feedbacks_questions: [:id, question: %i[id answer]]
        )
      end
    end
  end
end
