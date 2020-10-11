# frozen_string_literal: true

module Admin
  module Api
    class QuestionsController < ::Admin::Api::ApplicationController
      def create
        question = Question.new(question_params)
        render_active_model_errors(question) and return if question.invalid?

        question.save!

        head :created
      end

      private

      def question_params
        params.require(:question).permit(:text)
      end
    end
  end
end
