import Vue from 'vue';
import App from '@/App.vue';
import i18n from '@/i18n';
import router from '@/router/index';
import store from '@/store/index';
import 'vue-select/dist/vue-select.css';

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
