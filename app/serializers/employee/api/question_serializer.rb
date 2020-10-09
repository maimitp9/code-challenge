# frozen_string_literal: true

module Employee
  module Api
    class QuestionSerializer < ActiveModel::Serializer
      type :question

      attributes %i[id text]
    end
  end
end
