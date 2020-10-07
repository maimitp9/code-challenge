# frozen_string_literal: true

FactoryBot.define do
  factory :users_feedback do
    user { nil }
    feedback { nil }
    reviewer_id { 1 }
    status { 'MyString' }
  end
end
