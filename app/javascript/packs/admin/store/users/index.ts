import { Module } from "vuex";
import { actions } from "./actions";
import { getters } from "./getters";
import { mutations } from "./mutations";
import { UserState } from "./types";
import { RootState } from "../types";

const initialState: UserState = {};

export const users: Module<UserState, RootState> = {
  namespaced: true,
  state: initialState,
  actions,
  getters,
  mutations,
};
