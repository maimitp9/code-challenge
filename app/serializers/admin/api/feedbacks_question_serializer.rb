# frozen_string_literal: true

module Admin
  module Api
    class FeedbacksQuestionSerializer < ActiveModel::Serializer
      type :feedbacks_question

      attributes %i[id feedback_id question_id]

      has_many :question, if: -> { scope && scope[:question] }
      has_many :feedback, if: -> { scope && scope[:feedback] }
      has_many :feedbacks_questions_answers, if: -> { scope && scope[:feedbacks_questions_answers] }
    end
  end
end
