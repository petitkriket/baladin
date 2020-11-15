import { createApp } from 'vue';
import App from '@/App.vue';

export default () => {
  document.addEventListener('DOMContentLoaded', () => {
    const app = createApp(App);
    app.mount('#vue-app');
  });
};
