# frozen_string_literal: true

class Feedback < ApplicationRecord
  enum status: %i[active inactive]

  has_many :users_feedbacks
  has_many :users, through: :users_feedbacks
  has_many :feedbacks_questions_answers, foreign_key: 'feedback_id'

  validates :title, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: Feedback.statuses }
  USE_COLUMN_NAMES = %i[title status].freeze
end
