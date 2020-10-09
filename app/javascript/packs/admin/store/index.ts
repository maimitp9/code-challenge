import Vue from "vue";
import Vuex, { StoreOptions } from "vuex";
import { RootState } from "./types";

import ApiClient from "../lib/ApiClient";
import axios from "./axios";

Vue.use(Vuex);

const apiClient = new ApiClient({
  axios: axios,
  version: 0,
});

const initialState: RootState = {
  apiClient: apiClient,
  clientVersion: 0,
  currentUser: undefined,
};

import { mutations } from "./mutations";

import { users } from "./users";
import { feedbacks } from "./feedbacks";

const store: StoreOptions<RootState> = {
  state: initialState,
  mutations,
  modules: {
    users,
    feedbacks,
  },
};

export default new Vuex.Store<RootState>(store);
