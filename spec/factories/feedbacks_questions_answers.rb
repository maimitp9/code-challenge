# frozen_string_literal: true

FactoryBot.define do
  factory :feedbacks_questions_answer do
    feedback_question { nil }
    text { 'MyString' }
    user_id { 1 }
    reviewer_id { 1 }
  end
end
