# frozen_string_literal: true

# frozen_string_literal: true, if -> { scope && scope[:]}

module Admin
  module Api
    class FeedbacksQuestionsAnswerSerializer < ActiveModel::Serializer
      type :feedbacks_questions_answer

      attributes %i[id feedbacks_question_id text user_id reviewer_id]

      has_one :feedback, if: -> { scope && scope[:feedback] }
      has_one :question, if: -> { scope && scope[:question] }
      has_one :answer, if: -> { scope && scope[:answer] }
      has_one :user, if: -> { scope && scope[:user] }
      has_one :reviewer, if: -> { scope && scope[:reviewer] }
    end
  end
end
