import { AxiosInstance, AxiosRequestConfig, AxiosError } from "axios";

import ApiError from "./ApiError";
import ApiErrors from "./ApiErrors";
import User from "../models/User";
import Feedback from "../models/Feedback";

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

  async getUsers(): Promise<Array<User>> {
    try {
      const response = await this.axios.get("users");
      return response.data.users.map(u =>  new User(u));
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  async createUser(data: { id: number, name: string, email: string, password: string, password_confirmation: string, role: string }): Promise<User> {
    try {
      const response = await this.axios.post("users", {
        user: {
          name: data.name,
          email: data.email,
          password: data.password,
          password_confirmation: data.password_confirmation,
          role: data.role,
        },
      });
      return new User(response.data.user);
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  async getUser(userId: number): Promise<User> {
    try {
      const response = await this.axios.get(`users/${userId}`);
      return new User(response.data.user);
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  async updateUser(data: { id: number, name: string, email: string, password: string, password_confirmation: string, role: string }): Promise<User> {
    try {
      const response = await this.axios.put(`users/${data.id}`, {
        user: {
          id: data.id,
          name: data.name,
          email: data.email,
          password: data.password,
          password_confirmation: data.password_confirmation,
          role: data.role,
        },
      });
      return new User(response.data.user);
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  async deleteUser(userId: number): Promise<void> {
    try {
      await this.axios.delete(`users/${userId}`);
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

  // Feedbacks APIs
  async getFeedbacks(): Promise<Array<Feedback>> {
    try {
      const response = await this.axios.get("feedbacks");
      return response.data.feedbacks.map(u =>  new Feedback(u));
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }
  async createFeedback(data: { title: string, status: string, questions: Array<{text: string}> }): Promise<void> {
    try {
      await this.axios.post("feedbacks", {
        feedback: {
          title: data.title,
          status: data.status,
          questions: data.questions,
        },
      });
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }
  async getFeedback(feedbackId: number): Promise<Feedback> {
    try {
      const response = await this.axios.get(`feedbacks/${feedbackId}`);
      return new Feedback(response.data.feedback);
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }
  async assignFeedback(data: { user_id: number, feedback_id: number, reviewer_id: number }): Promise<void> {
    try {
      await this.axios.post("users_feedbacks", {
        usersFeedback: {
          user_id: data.user_id,
          feedback_id: data.feedback_id,
          reviewer_id: data.reviewer_id,
        },
      });
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }
  async getUserFeedbacks(userId: number): Promise<Feedback[]> {
    try {
      const response = await this.axios.get(`feedbacks/${userId}/user_feedbacks`);
      return response.data.feedbacks.map(f => new Feedback(f));
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
