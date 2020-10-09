import { ActionTree , Commit} from "vuex";
import { RootState } from "../types";
import { FeedbackState } from "./types";
import Feedback from "../../models/Feedback";

export const actions: ActionTree<FeedbackState, RootState> = {
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
};
