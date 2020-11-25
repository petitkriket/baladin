import * as MUTATIONS_TYPES from './mutations-types';

// eslint-disable-next-line import/prefer-default-export
export const mutations = {
  [MUTATIONS_TYPES.SET_ARTWORKS](state, payload) {
    state.list = payload;
  },
};
