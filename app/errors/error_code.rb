# frozen_string_literal: true

module ErrorCode
  VALIDATION_ACCEPTED =                 '400_0000'
  VALIDATION_BLANK =                    '400_0001'
  VALIDATION_PRESENT =                  '400_0002'
  VALIDATION_CONFIRMATION =             '400_0003'
  VALIDATION_EMPTY =                    '400_0004'
  VALIDATION_EQUAL_TO =                 '400_0005'
  VALIDATION_EVEN =                     '400_0006'
  VALIDATION_EXCLUSION =                '400_0007'
  VALIDATION_GREATER_THAN =             '400_0008'
  VALIDATION_GREATER_THAN_OR_EQUAL_TO = '400_0009'
  VALIDATION_INCLUSION =                '400_0010'
  VALIDATION_INVALID =                  '400_0011'
  VALIDATION_LESS_THAN =                '400_0012'
  VALIDATION_LESS_THAN_OR_EQUAL_TO =    '400_0013'
  VALIDATION_MODEL_INVALID =            '400_0014'
  VALIDATION_NOT_A_NUMBER =             '400_0015'
  VALIDATION_NOT_AN_INTEGER =           '400_0016'
  VALIDATION_ODD =                      '400_0017'
  VALIDATION_REQUIRED =                 '400_0018'
  VALIDATION_TAKEN =                    '400_0019'
  VALIDATION_TOO_SHORT =                '400_0020'
  VALIDATION_TOO_LONG =                 '400_0021'
  VALIDATION_WRONG_LENGTH =             '400_0022'
  VALIDATION_OTHER_THAN =               '400_0023'

  VALIDATION_OTHERS =                   '400_9999'

  NO_ROUTE_MATCH_OR_NOT_FOUND =         '404_0000'
  UNEXPECTED_ERROR =                    '500_0000'
end
