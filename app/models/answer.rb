# frozen_string_literal: true

class Answer < ApplicationRecord
  has_many :feedbacks_questions_answers
  has_many :feedbacks, through: :feedbacks_questions_answers
  has_many :questions, through: :feedbacks_questions_answers
end
