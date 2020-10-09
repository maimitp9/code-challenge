# frozen_string_literal: true

class FeedbacksQuestion < ApplicationRecord
  belongs_to :feedback
  belongs_to :question
  has_many :feedbacks_questions_answers
end
