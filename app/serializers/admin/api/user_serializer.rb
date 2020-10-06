# frozen_string_literal: true

module Admin
  module Api
    class UserSerializer < ActiveModel::Serializer
      type :user

      attributes User::USE_COLUMN_NAMES
    end
  end
end
