# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :feedbacks_questions
  has_many :feedbacks, through: :feedbacks_questions

  validates :text, presence: true, length: { maximum: 255 }
end
