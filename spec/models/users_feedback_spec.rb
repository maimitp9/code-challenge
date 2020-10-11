# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersFeedback, type: :model do
  let(:feedback) { create(:feedback) }
  let(:user) { create(:user) }
  let(:reviewer) { create(:user) }

  let(:users_feedback) { user.users_feedbacks.new({ feedback_id: feedback.id, reviewer_id: reviewer.id, status: 0 }) }

  describe 'validations' do
    it { expect(users_feedback).to be_valid }

    context 'when user_id is nil' do
      before do
        users_feedback.user_id = nil
      end

      it { expect(users_feedback).to be_invalid }
    end

    context 'when feedback is nill' do
      before do
        users_feedback.feedback_id = nil
      end

      it { expect(users_feedback).to be_invalid }
    end

    context 'when reviewer_id is nil' do
      before do
        users_feedback.reviewer_id = nil
      end

      it { expect(users_feedback).to be_invalid }
    end

    context 'when status is nill' do
      before do
        users_feedback.status = nil
      end

      it { expect(users_feedback).to be_invalid }
    end

    context 'when user_id and reviewer_id is same' do
      before do
        users_feedback.reviewer_id = user.id
      end

      it { expect(users_feedback).to be_invalid }
    end
  end
end
