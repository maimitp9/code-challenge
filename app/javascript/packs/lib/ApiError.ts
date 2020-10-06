class ApiError {
  code: string;
  key?: string;
  message: string;
  errorNo?: string;

  constructor(data: {
    code: string;
    key?: string;
    message: string;
    errorNo?: string;
  }) {
    this.code = data.code;
    this.key = data.key;
    this.message = data.message;
    this.errorNo = data.errorNo;
  }

  get fullMessage(): string {
    return `${this.message} [${this.code}]`;
  }
}

export default ApiError;
