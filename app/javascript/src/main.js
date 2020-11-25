import Vue from 'vue';
import App from '@/App.vue';
import store from '@/store/index';

document.addEventListener('DOMContentLoaded', () => {
  const el = '#app';
  const app = new Vue({
    el,
    store,
    render: (h) => h(App),
  });
  app.$mount();
});
