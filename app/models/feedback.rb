# frozen_string_literal: true

class Feedback < ApplicationRecord
  enum status: %i[active inactive]

  has_many :users_feedbacks
  has_many :users, through: :users_feedbacks
  has_many :reviewers, through: :users_feedbacks, class_name: 'User', foreign_key: 'reviewer_id'
  has_many :feedbacks_questions
  has_many :questions, through: :feedbacks_questions

  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: Feedback.statuses }
  USE_COLUMN_NAMES = %i[id title status].freeze
end
