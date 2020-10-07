# frozen_string_literal: true

class MailAddressFormatValidator < ::ActiveModel::EachValidator
  VALID_PATTERN = %r(\A[a-zA-Z0-9_\-+/*?][a-zA-Z0-9_\-+/*?.]*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}\z)
                  .freeze

  def validate_each(record, attribute, value)
    return if value.blank?
    return unless value.is_a?(::String)

    record.errors.add(attribute, :invalid_mail_address_format) unless VALID_PATTERN.match?(value)
  end
end
