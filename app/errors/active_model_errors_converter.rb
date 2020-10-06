# frozen_string_literal: true

module ActiveModelErrorsConverter
  DEFAULT_ERROR_CODE = ::ErrorCode::VALIDATION_OTHERS
  MAP = {
    accepted: ErrorCode::VALIDATION_ACCEPTED,
    blank: ErrorCode::VALIDATION_BLANK,
    present: ErrorCode::VALIDATION_PRESENT,
    confirmation: ErrorCode::VALIDATION_CONFIRMATION,
    empty: ErrorCode::VALIDATION_EMPTY,
    equal_to: ErrorCode::VALIDATION_EQUAL_TO,
    even: ErrorCode::VALIDATION_EVEN,
    exclusion: ErrorCode::VALIDATION_EXCLUSION,
    greater_than: ErrorCode::VALIDATION_GREATER_THAN,
    greater_than_or_equal_to: ErrorCode::VALIDATION_GREATER_THAN_OR_EQUAL_TO,
    inclusion: ErrorCode::VALIDATION_INCLUSION,
    invalid: ErrorCode::VALIDATION_INVALID,
    less_than: ErrorCode::VALIDATION_LESS_THAN,
    less_than_or_equal_to: ErrorCode::VALIDATION_LESS_THAN_OR_EQUAL_TO,
    model_invalid: ErrorCode::VALIDATION_MODEL_INVALID,
    not_a_number: ErrorCode::VALIDATION_NOT_A_NUMBER,
    not_an_integer: ErrorCode::VALIDATION_NOT_AN_INTEGER,
    odd: ErrorCode::VALIDATION_ODD,
    required: ErrorCode::VALIDATION_REQUIRED,
    taken: ErrorCode::VALIDATION_TAKEN,
    too_short: ErrorCode::VALIDATION_TOO_SHORT,
    too_long: ErrorCode::VALIDATION_TOO_LONG,
    wrong_length: ErrorCode::VALIDATION_WRONG_LENGTH,
    other_than: ErrorCode::VALIDATION_OTHER_THAN
  }.freeze

  # @param [ActiveModel::Errors] errors
  # @param [Class] model_class
  # @return [Array<User::Api::Error>]
  def self.convert(errors, model_class = nil)
    result = []
    errors.keys.each do |attr|
      key = attr == :base ? nil : attr
      details = errors.details[attr]
      messages = errors.messages[attr]
      details.zip(messages) do |dtl, msg|
        cause = dtl[:error]
        code = MAP.dig(model_class, cause) || MAP[cause] || DEFAULT_ERROR_CODE
        msg = errors.full_message(attr, msg)

        result << Error.new(key: key, code: code, message: msg)
      end
    end
    result
  end
end
