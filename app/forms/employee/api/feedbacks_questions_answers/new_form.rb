# frozen_string_literal: true

module Employee
  module Api
    module FeedbacksQuestionsAnswers
      class NewForm
        include ::ActiveModel::Model

        attr_accessor :user_id, :reviewer_id, :users_feedbacks_id,
                      :feedbacks_questions

        validates :user_id, presence: true
        validates :reviewer_id, presence: true
        validates :users_feedbacks_id, presence: true
        validates :feedbacks_questions, presence: true
        validate :check_feedbacks_questions_answers

        def persist!
          ActiveRecord::Base.transaction do
            create_feedbacks_questions_answers!
            update_users_feedback!
          end
        end

        private

        def update_users_feedback!
          users_feedback = UsersFeedback.find(users_feedbacks_id)
          users_feedback.update(status: 1)
        end

        def create_feedbacks_questions_answers!
          feedbacks_questions.each do |attr|
            FeedbacksQuestionsAnswer.create!(
              {
                feedbacks_question_id: attr[:id],
                text: attr[:question][:answer],
                user_id: user_id,
                reviewer_id: reviewer_id
              }
            )
          end
        end

        def check_feedbacks_questions_answers
          feedbacks_questions.each do |attr|
            unless attr[:id].present?
              errors.add(:base, "feedbacks_question_id can't be blank")
              break
            end
            unless attr[:question][:answer].present?
              errors.add(:base, "Feedback can't be blank")
              break
            end
          end
        end
      end
    end
  end
end
