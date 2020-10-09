import { Module } from "vuex";
import { actions } from "./actions";
import { getters } from "./getters";
import { mutations } from "./mutations";
import { FeedbackState } from "./types";
import { RootState } from "../types";

const initialState: FeedbackState = {};

export const feedbacks: Module<FeedbackState, RootState> = {
  namespaced: true,
  state: initialState,
  actions,
  getters,
  mutations,
};
