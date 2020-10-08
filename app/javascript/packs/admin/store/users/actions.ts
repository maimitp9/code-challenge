import { ActionTree , Commit} from "vuex";
import { RootState } from "../types";
import { UserState } from "./types";
import User from "../../models/User";

export const actions: ActionTree<UserState, RootState> = {
  async getUsers(
    context: { rootState: RootState }
  ): Promise<Array<User>> {
    return await context.rootState.apiClient.getUsers();
  },
  async createUser(
    context: { rootState: RootState },
    payload: { id: number, name: string, email: string, password: string, password_confirmation: string, role: string }
  ): Promise<User> {
    return await context.rootState.apiClient.createUser(payload)
  },
  async getUser(
    context: { rootState: RootState },
    payload: { userId: number }
  ): Promise<User> {
    return await context.rootState.apiClient.getUser(payload.userId);
  },
  async updateUser(
    context: { rootState: RootState },
    payload: { id: number, name: string, email: string, password: string, password_confirmation: string, role: string }
  ): Promise<User> {
    console.log("calling", payload)
    return await context.rootState.apiClient.updateUser(payload);
  },
  async deleteUser(
    context: { rootState: RootState },
    payload: { userId: number }
  ): Promise<void> {
    await context.rootState.apiClient.deleteUser(payload.userId);
  },
};
