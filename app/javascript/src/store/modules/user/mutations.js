import * as MUTATIONS_TYPES from './mutations-types';

// eslint-disable-next-line import/prefer-default-export
export const mutations = {
  [MUTATIONS_TYPES.SET_LOCALE](state, payload) {
    state.settings.locale = payload;
  },
};
