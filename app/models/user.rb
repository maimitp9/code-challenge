# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum role: %i[admin employee]
  enum status: %i[active inactive]

  has_many :users_feedbacks
  has_many :feedbacks, through: :users_feedbacks

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, mail_address_format: true
  validates :password, presence: true, length: { in: 6..20 }, confirmation: true, allow_blank: true
  validates :password_confirmation, presence: true, allow_blank: true
  validates :role, presence: true, inclusion: { in: User.roles }
  validates :status, presence: true, inclusion: { in: User.statuses }

  USE_COLUMN_NAMES = %i[id name email role status].freeze
end
