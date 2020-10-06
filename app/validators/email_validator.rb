# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = %r{\A([a-zA-Z0-9_\-+/*?][a-zA-Z0-9_\-+/*?.]*)@((?:[a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,})\z}.freeze

  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, options[:message] || :invalid) unless value.match?(EMAIL_REGEX)
  end
end
