import Vue from 'vue';

import i18n from './plugins/i18n';
import router from './router/index';
import store from './store/index';
import './theme.scss';

import App from './App.vue';

const requireConfig = require.context('@/plugins', true, /\.js$/);
requireConfig.keys().forEach(requireConfig);

Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  const el = '#app';
  const app = new Vue({
    el,
    i18n,
    router,
    store,
    render: (h) => h(App),
  });
  app.$mount();
});
