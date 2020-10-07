import { AxiosInstance, AxiosRequestConfig, AxiosError } from "axios";

import ApiError from "./ApiError";
import ApiErrors from "./ApiErrors";

class ApiClient {
  axios: AxiosInstance;
  version: number;

  constructor(config: { axios: AxiosInstance; version: number }) {
    this.axios = this.setAxiosInterceptors(config.axios);
    this.version = config.version;
  }

  private setAxiosInterceptors(axios: AxiosInstance): AxiosInstance {
    // Set HTTP header in all API requests
    axios.interceptors.request.use(
      (config: AxiosRequestConfig): AxiosRequestConfig => {
        config.headers["X-Client-Version"] = this.version;
        return config;
      },
      (error): any => {
        return Promise.reject(error);
      }
    );
    return axios;
  }

  async login(data: {
    email: string;
    password: string;
  }): Promise<string> {
    try {
      console.log(data)
      const response = await this.axios.post("session", {
        session: {
          email: data.email,
          password: data.password,
        }
      });
      return response.headers.location;
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  async logout(): Promise<void> {
    try {
      await this.axios.delete("session");
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  static convertError(axiosError: AxiosError): ApiErrors {
    const response = axiosError.response;
    if (response) {
      if (response.data.errors) {
        const errors = response.data.errors.map((e: any) => new ApiError(e));
        return new ApiErrors({
          status: response.status,
          errors: errors,
          response: response,
        });
      } else {
        return new ApiErrors({
          status: response.status,
          errors: ApiErrors.defaultServerErrors(),
          response: response,
        });
      }
    } else {
      return new ApiErrors({
        status: 0,
        errors: ApiErrors.defaultNetworkError(),
      });
    }
  }
}

export default ApiClient;
