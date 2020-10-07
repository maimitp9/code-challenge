# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailAddressFormatValidator do
  subject { temp_class.new(email) }

  let(:temp_class) do
    ::Class.new do
      include ::ActiveModel::Validations

      attr_accessor :email

      validates :email, mail_address_format: true

      def self.model_name
        ::ActiveModel::Name.new(self, nil, 'temp')
      end

      def initialize(email)
        @email = email
      end
    end
  end

  context 'email is nil' do
    let(:email) { nil }

    it { is_expected.to be_valid }
  end

  context 'email is not String' do
    let(:email) { 1 }

    it { is_expected.to be_valid }
  end

  context 'email is empty string' do
    let(:email) { '' }

    it { is_expected.to be_valid }
  end

  context 'email is valid mail address format' do
    let(:email) { 'azAZ09_-+/*?.@sub-2.sub-1.top' }

    it { is_expected.to be_valid }
  end

  context 'email does not contain @' do
    let(:email) { 'no_at.mark' }

    it { is_expected.to be_invalid }
  end

  context 'email contains two @' do
    let(:email) { 'local@@sub.top' }

    it { is_expected.to be_invalid }
  end

  context 'no local part' do
    let(:email) { '@y-main.com' }

    it { is_expected.to be_invalid }
  end

  context 'local part contains invalid chars' do
    let(:email) { 'invalid-#$%^&-chars@y-main.com' }

    it { is_expected.to be_invalid }
  end

  context 'local part contains multi byte chars' do
    let(:email) { 'フォト@y-main.com' }

    it { is_expected.to be_invalid }
  end

  context 'local part is start with .' do
    let(:email) { '.local-part@y-main.com' }

    it { is_expected.to be_invalid }
  end

  context 'no sub domain' do
    let(:email) { 'local-part@jp' }

    it { is_expected.to be_invalid }
  end

  context 'sub doman part contains invalid chars' do
    let(:email) { 'local-part@sub_+&.top' }

    it { is_expected.to be_invalid }
  end

  context 'length of top level domain is 1' do
    let(:email) { 'local-part@sub-1.j' }

    it { is_expected.to be_invalid }
  end

  context 'top level domain contains invalid chars' do
    let(:email) { 'local-part@sub-1.jp1' }

    it { is_expected.to be_invalid }
  end
end
