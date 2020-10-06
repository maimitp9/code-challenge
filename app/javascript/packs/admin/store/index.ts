import Vue from "vue";
import Vuex, { StoreOptions } from "vuex";
import { RootState } from "./types";

import ApiClient from "../../lib/ApiClient";
import axios from "./axios";

Vue.use(Vuex);

const apiClient = new ApiClient({
  axios: axios,
  version: 0,
});

const initialState: RootState = {
  apiClient: apiClient,
  clientVersion: 0,
};

import { mutations } from "./mutations";

const store: StoreOptions<RootState> = {
  state: initialState,
  mutations,
  modules: {},
};

export default new Vuex.Store<RootState>(store);
