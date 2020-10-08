# frozen_string_literal: true

class FeedbacksQuestionsAnswer < ApplicationRecord
  belongs_to :feedback
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  USE_COLUMN_NAMES = %i[feedback_id user_id reviewer_id question_id].freeze
end
