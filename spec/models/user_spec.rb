# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    it { expect(user).to be_valid }

    context 'when email is empty string' do
      before do
        user.email = ''
      end

      it { expect(user).to be_invalid }
    end

    context 'when password and password_confirmation  is empty string' do
      before do
        user.password = ''
        user.password_confirmation = ''
      end

      it { expect(user).to be_invalid }
    end

    context 'when password not match' do
      before do
        user.password_confirmation = '98765432'
      end

      it { expect(user).to be_invalid }
    end

    context 'when role is nil' do
      before do
        user.role = nil
      end

      it { expect(user).to be_invalid }
    end

    context 'when status is nil' do
      before do
        user.status = nil
      end

      it { expect(user).to be_invalid }
    end
  end

  describe 'Active Record Associations' do
    let(:user) { create(:user) }
    let(:reviewer) { create(:user) }
    let(:feedback) { create(:feedback) }

    before do
      user.users_feedbacks.create!({ feedback_id: feedback.id, reviewer_id: reviewer.id })
    end

    it 'user has many feedbacks' do
      expect(user.feedbacks).to eq([feedback])
    end
  end
end
