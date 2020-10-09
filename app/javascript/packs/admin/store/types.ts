import ApiClient from "../lib/ApiClient";
import User from "../models/User";

export interface RootState {
  apiClient: ApiClient;
  clientVersion: number;
  currentUser: User;
}