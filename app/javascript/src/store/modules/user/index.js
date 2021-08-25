import { selectedLocale } from '../../../plugins/i18n';
import { getters } from './getters';
import actions from './actions';
import mutations from './mutations';

const state = {
  user: {},
  token: null,
  settings: {
    locale: selectedLocale,
  },
  contributions: [],
};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
