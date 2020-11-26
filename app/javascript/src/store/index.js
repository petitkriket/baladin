import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import artworks from '@/store/modules/artworks/index';
import user from '@/store/modules/user/index';

Vue.use(Vuex);

const modules = { artworks, user };

export default new Vuex.Store({
  modules,
  strict: process.env.NODE_ENV !== 'production',
  plugins: [
    createPersistedState(),
  ],
});
