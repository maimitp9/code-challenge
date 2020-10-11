import ApiError from "./ApiError";

import {
  API_ERROR_CODE_DEFAULT_SERVER_ERROR_CODE,
  API_ERROR_CODE_DEFAULT_CLIENT_ERROR_CODE,
} from "./ApiErrorCodes";

class ApiErrors {
  status: number;
  errors: Array<ApiError>;
  response?: any;

  constructor(data: {
    status: number;
    errors: Array<ApiError>;
    response?: any;
  }) {
    this.status = data.status;
    this.errors = data.errors;
    this.response = data.response;
  }

  getErrorCode(): string | undefined {
    return this.errors.map((e) => e.code)[0];
  }

  getErrorMessage(): string {
    return this.getErrorMessages().join(", ");
  }

  getErrorMessages(): Array<string> {
    return this.errors.map((e) => e.fullMessage);
  }

  is50xError(): boolean {
    return !!this.status && this.status.toString()[0] == "5";
  }

  static defaultServerErrors(): Array<ApiError> {
    return [
      new ApiError({
        code: API_ERROR_CODE_DEFAULT_SERVER_ERROR_CODE,
        message:
          "There is a problem with your server. Please wait for a while and try again.",
      }),
    ];
  }

  static defaultNetworkError(): Array<ApiError> {
    return [
      new ApiError({
        code: API_ERROR_CODE_DEFAULT_CLIENT_ERROR_CODE,
        message:
          "There was a problem with the network communication. Please try again in a better location.",
      }),
    ];
  }
}

export default ApiErrors;
