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

  // START Attendance front API
  // async getAttendance(
  //   groupId: number,
  //   kidId: number,
  //   data: {
  //     dateRangeStart: string;
  //     dateRangeEnd: string;
  //   }
  // ): Promise<Array<Attendance>> {
  //   try {
  //     const response = await this.axios.get(
  //       `groups/${groupId}/kids/${kidId}/attendances`,
  //       {
  //         params: {
  //           dateRangeStart: data.dateRangeStart,
  //           dateRangeEnd: data.dateRangeEnd,
  //         },
  //       }
  //     );
  //     return response.data.attendances.map((a: any) => new Attendance(a));
  //   } catch (error) {
  //     throw ApiClient.convertError(error);
  //   }
  // }

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
