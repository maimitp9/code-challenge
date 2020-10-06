# frozen_string_literal: true

module Api
  module V1
    module Admin
      class UserSerializer < ActiveModel::Serializer
        type :user

        attributes User::USE_COLUMN_NAMES
      end
    end
  end
end
