import i18n from '@/plugins/i18n';
import * as MUTATIONS_TYPES from './mutations-types';
import * as ACTIONS_TYPES from './actions-types';

// eslint-disable-next-line import/prefer-default-export
export const actions = {
  [ACTIONS_TYPES.UPDATE_LOCALE]({ commit }, params) {
    i18n.locale = params;
    commit(MUTATIONS_TYPES.SET_LOCALE, params);
  },
};
