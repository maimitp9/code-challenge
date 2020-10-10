import { ActionTree , Commit} from "vuex";
import { RootState } from "../types";
import { FeedbackState } from "./types";
import Feedback from "../../models/Feedback";

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
  async assignFeedback(
    context: { rootState: RootState },
    payload: { user_id: number, feedback_id: number, reviewer_id: number }
  ): Promise<void> {
    await context.rootState.apiClient.assignFeedback(payload)
  },
  async getUserFeedbacks(
    context: { rootState: RootState },
    payload: { userId: number }
  ): Promise<Feedback[]> {
    return await context.rootState.apiClient.getUserFeedbacks(payload.userId);
  },
};
