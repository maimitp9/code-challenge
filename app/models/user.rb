# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum role: %i[admin employee]

  has_many :users_feedbacks
  has_many :feedbacks, through: :users_feedbacks

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, mail_address_format: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :role, presence: true, inclusion: { in: User.roles }

  USE_COLUMN_NAMES = %i[id name email role].freeze
end
