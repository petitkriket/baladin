import Vue from 'vue';
import { ModalPlugin, LayoutPlugin, ToastPlugin } from 'bootstrap-vue';

Vue.use(LayoutPlugin);
Vue.use(ModalPlugin);
Vue.use(ToastPlugin,
  {
    BToast: {
      toastClass: 'mt-5',
      noCloseButton: true,
    },
  });
