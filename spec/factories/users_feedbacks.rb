# frozen_string_literal: true

FactoryBot.define do
  factory :users_feedback do
    user { '' }
    feedback { '' }
    question { '' }
    answer { '' }
  end
end
