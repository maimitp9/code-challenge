# frozen_string_literal: true

class FeedbacksQuestionsAnswer < ApplicationRecord
  belongs_to :feedback_question, optional: true
end
