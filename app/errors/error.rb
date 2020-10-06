# frozen_string_literal: true

class Error
  include ::ActiveModel::Serializers::JSON
  include ::ActiveModel::Model

  attr_accessor :code, :key, :message, :error_no
  def attributes
    {
      'code' => nil,
      'key' => nil,
      'message' => nil,
      'error_no' => nil
    }
  end
end
