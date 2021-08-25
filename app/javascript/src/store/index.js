import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import artworks from './modules/artworks/index';
import user from './modules/user/index';
import map from './modules/map';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: { artworks, user, map },
  strict: process.env.NODE_ENV !== 'production',
  plugins: [
    createPersistedState(),
  ],
});
