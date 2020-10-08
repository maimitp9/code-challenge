# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :feedbacks_questions_answers
  has_many :feedbacks, through: :feedbacks_questions_answers
  has_many :answers, through: :feedbacks_questions_answers
end
