import { ActionTree , Commit} from "vuex";
import { RootState } from "../types";
import { FeedbackState } from "./types";
import Feedback from "../../models/Feedback";
import Question from "../../models/Question";

export const actions: ActionTree<FeedbackState, RootState> = {
  async getFeedbacks(
    context: { rootState: RootState }
  ): Promise<Array<Feedback>> {
    return await context.rootState.apiClient.getFeedbacks();
  },
  async createFeedback(
    context: { rootState: RootState },
    payload: { title: string, status: string, questions: Array<{text: string}> }
  ): Promise<void> {
    await context.rootState.apiClient.createFeedback(payload)
  },
  async getFeedback(
    context: { rootState: RootState },
    payload: { feedbackId: number }
  ): Promise<Feedback> {
    return await context.rootState.apiClient.getFeedback(payload.feedbackId);
  },
  async giveFeedback(
    context: { rootState: RootState },
    payload: { userId: number, reviewerId: number, usersFeedbacksId: number, feedbacksQuestions: Array<{id: string, question: Question}>}
  ): Promise<void> {
    await context.rootState.apiClient.giveFeedback(payload);
  }
};
