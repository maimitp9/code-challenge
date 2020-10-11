# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbacksQuestionsAnswer, type: :model do
  let(:feedback) { create(:feedback) }
  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:reviewer) { create(:user) }

  describe 'Active Record Associations' do
    let(:feedbacks_question) { FeedbacksQuestion.first }
    let(:feedbacks_questions_answer) do
      feedbacks_question.feedbacks_questions_answers.create!(
        {
          user_id: user.id, reviewer_id: reviewer.id, text: 'answer'
        }
      )
    end

    before do
      feedback.questions << question
    end

    it 'belongs to feedbacks_question' do
      expect(feedbacks_questions_answer.feedbacks_question).to eq(feedbacks_question)
    end

    it 'belongs to user' do
      expect(feedbacks_questions_answer.user).to eq(user)
    end

    it 'belongs to reviewer' do
      expect(feedbacks_questions_answer.reviewer).to eq(reviewer)
    end
  end
end
