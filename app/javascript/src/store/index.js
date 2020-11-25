import Vue from 'vue';
import Vuex from 'vuex';
import artworks from './modules/artworks/index';

Vue.use(Vuex);

const modules = { artworks };

export default new Vuex.Store({
  modules,
  strict: process.env.NODE_ENV !== 'production',
});
