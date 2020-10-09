# frozen_string_literal: true

module Employee
  module Api
    class FeedbacksQuestionSerializer < ActiveModel::Serializer
      type :feedbacks_question

      attributes %i[id feedback_id question_id]

      has_many :question, if: -> { scope && scope[:question] }
      has_many :feedback, if: -> { scope && scope[:feedback] }
    end
  end
end
