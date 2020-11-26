import { selectedLocale } from '@/plugins/i18n';
import { actions } from './actions';
import { mutations } from './mutations';

const state = {
  settings: {
    locale: selectedLocale,
  },
};

export default {
  namespaced: true,
  state,
  actions,
  mutations,
};
