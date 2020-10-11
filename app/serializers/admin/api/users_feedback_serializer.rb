# frozen_string_literal: true

# frozen_string_literal: true, if: -> { scope && scope[:] }

module Admin
  module Api
    class UsersFeedbackSerializer < ActiveModel::Serializer
      type :users_feedback

      attributes UsersFeedback::USE_COLUMN_NAMES

      has_many :user, if: -> { scope && scope[:user] }
      has_many :reviewer, if: -> { scope && scope[:reviewer] }
    end
  end
end
