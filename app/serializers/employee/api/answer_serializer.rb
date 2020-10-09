# frozen_string_literal: true

module Employee
  module Api
    class AnswerSerializer < ActiveModel::Serializer
      type :answer

      attributes %i[id text]
    end
  end
end
