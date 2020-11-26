import Vue from 'vue';
import App from '@/App.vue';
import router from '@/router/index';
import store from '@/store/index';

document.addEventListener('DOMContentLoaded', () => {
  const el = '#app';
  const app = new Vue({
    el,
    router,
    store,
    render: (h) => h(App),
  });
  app.$mount();
});
