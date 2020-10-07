import { MutationTree } from 'vuex';
import { RootState } from './types';

export const mutations: MutationTree<RootState> = {
  init(
    state: RootState,
    data: {
      clientVersion: number;
    }
  ): any {
    state.clientVersion = data.clientVersion;
  }
};