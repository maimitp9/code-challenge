# frozen_string_literal: true

class UsersFeedback < ApplicationRecord
  # enum status: %i[pending completed]

  belongs_to :user
  belongs_to :feedback
  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'

  validates :user_id, presence: true
  validates :feedback_id, presence: true
  validates :reviewer_id, presence: true
  # validates :status, presence: true, inclusion: { in: UsersFeedback.statuses }
  validates :user_id, uniqueness: { scope: %i[feedback_id reviewer_id] }

  USE_COLUMN_NAMES = %i[user_id feedback_id reviewer_id].freeze
end
