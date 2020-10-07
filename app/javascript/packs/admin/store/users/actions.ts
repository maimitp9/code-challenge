import { ActionTree , Commit} from "vuex";
import { RootState } from "../types";
import { UserState } from "./types";
import User from "../../models/User";

export const actions: ActionTree<UserState, RootState> = {
  async getUsers(
    context: { commit: Commit; rootState: RootState }
  ): Promise<Array<User>> {
    return await context.rootState.apiClient.getUsers();
  },
  async deleteUser(
    context: { commit: Commit; rootState: RootState },
    payload: { userId: number }
  ): Promise<void> {
    await context.rootState.apiClient.deleteUser(payload.userId);
  },
};
