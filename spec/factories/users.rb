# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'user_name' }
    email { 'test@gmail.com' }
    password { '12345678' }
    role { 1 }
  end
end
