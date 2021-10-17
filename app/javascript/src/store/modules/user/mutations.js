import * as MUTATIONS_TYPES from './mutations-types';

const mutations = {
  [MUTATIONS_TYPES.SET_LOCALE](state, payload) {
    state.settings.locale = payload;
  },
  [MUTATIONS_TYPES.SET_USER](state, payload) {
    state.user = payload;
  },
  [MUTATIONS_TYPES.SET_TOKEN](state, payload) {
    state.token = payload;
  },
  [MUTATIONS_TYPES.SET_CONTRIBUTIONS](state, payload) {
    state.contributions = payload;
  },
  [MUTATIONS_TYPES.EDIT_CONTRIBUTION](state, payload) {
    const index = state.contributions.findIndex((event) => (event.id === payload.id));
    state.contributions.splice(index, 1, payload);
  },
};

export default mutations;
