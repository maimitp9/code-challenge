import { AxiosInstance, AxiosRequestConfig, AxiosError } from "axios";

import ApiError from "./ApiError";
import ApiErrors from "./ApiErrors";

import Feedback from "../models/Feedback";
import Question from "../models/Question";

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

  async logout(): Promise<void> {
    try {
      await this.axios.delete("session");
    } catch (error) {
      throw ApiClient.convertError(error);
    }
  }

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
  async giveFeedback(data: { userId: number, reviewerId: number, usersFeedbacksId:number, feedbacksQuestions: Array<{id: string, question: Question}> }): Promise<void> {
    try {
      await this.axios.post("feedbacks_questions_answers", {
        feedbacksQuestionsAnswer: {
          userId: data.userId,
          reviewerId: data.reviewerId,
          usersFeedbacksId: data.usersFeedbacksId,
          feedbacksQuestions: data.feedbacksQuestions,
        },
      });
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
