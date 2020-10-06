import Vue from 'vue';
import Vuex, { StoreOptions, Store } from 'vuex';
import { RootState } from './types';

Vue.use(Vuex);

const initialState: RootState = {
  clientVersion: 0
};


import { mutations } from './mutations';

const store: StoreOptions<RootState> = {
  state: initialState,
  mutations,
  modules: {}
};

export default new Vuex.Store<RootState>(store);