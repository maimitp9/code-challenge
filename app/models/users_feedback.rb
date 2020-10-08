# frozen_string_literal: true

class UsersFeedback < ApplicationRecord
  # enum status: %i[pending completed]

  belongs_to :user
  belongs_to :feedback
  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'
  has_many :feedbacks_questions_answers, foreign_key: 'feedback_id'
  has_many :questions, through: :feedbacks_questions_answers
  has_many :feedbacks_questions_answers_by_user,
           class_name: 'FeedbacksQuestionsAnswer',
           foreign_key: 'user_id', primary_key: 'user_id'
  has_many :feedbacks_questions_answers_by_reviewer,
           class_name: 'FeedbacksQuestionsAnswer',
           foreign_key: 'reviewer_id', primary_key: 'reviewer_id'

  validates :user_id, presence: true
  validates :feedback_id, presence: true
  validates :reviewer_id, presence: true
  # validates :status, presence: true, inclusion: { in: UsersFeedback.statuses }
  validates :user_id, uniqueness: { scope: %i[feedback_id reviewer_id] }

  USE_COLUMN_NAMES = %i[user_id feedback_id reviewer_id].freeze
end
