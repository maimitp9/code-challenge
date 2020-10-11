# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question) }

  describe 'validations' do
    it { expect(question).to be_valid }

    context 'when text is empty string' do
      before do
        question.text = ''
      end

      it { expect(question).to be_invalid }
    end
  end

  describe 'Active Record Associations' do
    let(:question) { create(:question) }
    let(:feedback) { create(:feedback) }

    before do
      question.feedbacks << feedback
    end

    it 'has many users' do
      expect(question.feedbacks).to eq([feedback])
    end
  end
end
