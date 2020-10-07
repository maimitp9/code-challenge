# frozen_string_literal: true

class Feedback < ApplicationRecord
  enum status: %i[active inactive]

  has_many :users_feedbacks
  has_many :users, through: :users_feedbacks

  validates :year, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: Feedback.statuses }
end
