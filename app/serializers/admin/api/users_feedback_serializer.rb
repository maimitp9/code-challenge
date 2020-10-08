# frozen_string_literal: true

# frozen_string_literal: true, if: -> { scope && scope[:] }

module Admin
  module Api
    class UsersFeedbackSerializer < ActiveModel::Serializer
      type :users_feedback

      attributes UsersFeedback::USE_COLUMN_NAMES

      has_many :feedbacks_questions_answers_by_user,
               key: :by_user,
               if: -> { scope && scope[:feedbacks_questions_answers_by_user] }
    end
  end
end
