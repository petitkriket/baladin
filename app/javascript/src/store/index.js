import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import artworks from '@/store/modules/artworks/index';
import user from '@/store/modules/user/index';
import map from '@/store/modules/map';

Vue.use(Vuex);

const modules = { artworks, user, map };

export default new Vuex.Store({
  modules,
  strict: process.env.NODE_ENV !== 'production',
  plugins: [
    createPersistedState(),
  ],
});
