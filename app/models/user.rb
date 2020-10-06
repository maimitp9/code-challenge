# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum role: %i[admin employee]

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :role, presence: true, inclusion: { in: User.roles }

  USE_COLUMN_NAMES = %i[id name email role].freeze
end