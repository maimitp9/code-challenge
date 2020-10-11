# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:feedback) { build(:feedback) }

  describe 'validations' do
    it { expect(feedback).to be_valid }

    context 'when title is empty string' do
      before do
        feedback.title = ''
      end

      it { expect(feedback).to be_invalid }
    end

    context 'when status is nill' do
      before do
        feedback.status = ''
      end

      it { expect(feedback).to be_invalid }
    end
  end

  describe 'Active Record Associations' do
    let(:user) { create(:user) }
    let(:reviewer) { create(:user) }
    let(:feedback) { create(:feedback) }

    before do
      feedback.users_feedbacks.create!({ user_id: user.id, reviewer_id: reviewer.id })
    end

    it 'has many users' do
      expect(feedback.users).to eq([user])
    end

    it 'has many reviewers' do
      expect(feedback.reviewers).to eq([reviewer])
    end

    context 'has many questions' do
      let(:question) { create(:question) }

      before do
        feedback.questions << question
      end
      it { expect(feedback.questions).to eq([question]) }
    end
  end
end
