# frozen_string_literal: true

class FeedbacksQuestionsAnswer < ApplicationRecord
  belongs_to :feedbacks_question, optional: true
  belongs_to :user
  belongs_to :reviewer, class_name: 'User', foreign_key: :reviewer_id
end
