# frozen_string_literal: true

module Admin
  module Api
    module Feedbacks
      class NewForm
        include ::ActiveModel::Model

        attr_accessor :title, :status, :questions

        validates :title, presence: true
        validates :status, presence: true, inclusion: { in: Feedback.statuses }
        validates :questions, presence: true, length: { maximum: 5 }

        def persist!
          ActiveRecord::Base.transaction do
            feedback.save!
            create_questions!
          end
        end

        private

        def feedback
          @feedback ||= Feedback.new(title: title, status: status)
        end

        def create_questions!
          questions.each do |attr|
            feedback.questions.create!(text: attr[:text])
          end
        end
      end
    end
  end
end
