import ApiClient from "../../lib/ApiClient";
export interface RootState {
  apiClient: ApiClient;
  clientVersion: number;
}