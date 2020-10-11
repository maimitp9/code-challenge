# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbacksQuestion, type: :model do
  let(:feedback) { create(:feedback) }
  let(:question) { create(:question) }

  describe 'Active Record Associations' do
    before do
      feedback.questions << question
    end

    it 'belongs to question' do
      expect(FeedbacksQuestion.first.question).to eq(question)
    end

    it 'belongs to feedback' do
      expect(FeedbacksQuestion.first.feedback).to eq(feedback)
    end

    context 'has many feedbacks_questions_answers' do
      let(:user) { create(:user) }
      let(:reviewer) { create(:user) }
      let(:feedbacks_question) { FeedbacksQuestion.first }
      let(:feedbacks_questions_answers) do
        feedbacks_question.feedbacks_questions_answers.create!(
          {
            user_id: user.id, reviewer_id: reviewer.id, text: 'answer'
          }
        )
      end

      it {
        expect(feedbacks_question.feedbacks_questions_answers)
          .to eq([feedbacks_questions_answers])
      }
    end
  end
end
