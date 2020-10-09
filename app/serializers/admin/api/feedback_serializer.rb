# frozen_string_literal: true

module Admin
  module Api
    class FeedbackSerializer < ActiveModel::Serializer
      type :feedback

      Feedback::USE_COLUMN_NAMES.each do |attr|
        attribute attr, if: -> { object.respond_to?(attr) }
      end

      has_many :questions, if: -> { scope && scope[:questions] }
      has_many :users, if: -> { scope && scope[:users] }
      has_many :users_feedbacks, if: -> { scope && scope[:users_feedbacks] }
    end
  end
end
