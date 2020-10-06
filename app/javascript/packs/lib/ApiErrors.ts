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

  getErrorNo(): string | undefined {
    const error = this.errors[0];
    return error && error.errorNo;
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
        // TODO
        code: API_ERROR_CODE_DEFAULT_SERVER_ERROR_CODE,
        message:
          "サーバーで問題が発生しています。しばらく待ってから、再度アクセスください。",
      }),
    ];
  }

  static defaultNetworkError(): Array<ApiError> {
    return [
      new ApiError({
        // TODO
        code: API_ERROR_CODE_DEFAULT_CLIENT_ERROR_CODE,
        message:
          "ネットワーク通信で問題が発生しました。通信状況のよい場所で再度アクセスください。",
      }),
    ];
  }
}

export default ApiErrors;
