import { MutationTree } from 'vuex';
import { RootState } from './types';
import User from '../models/User';

export const mutations: MutationTree<RootState> = {
  init(
    state: RootState,
    data: {
      clientVersion: number;
      currentUser: User;
    }
  ): any {
    state.clientVersion = data.clientVersion;
    state.currentUser = data.currentUser;
  }
};