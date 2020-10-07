# frozen_string_literal: true

module Admin
  module Sessions
    class NewForm
      include ::ActiveModel::Model

      attr_accessor :email, :password

      validates :email, presence: true
      validates :password, presence: true
    end
  end
end
