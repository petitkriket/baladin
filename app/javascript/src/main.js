import Vue from 'vue'
import App from '@/App.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = '#app'
  const app = new Vue({
    el,
    render: h => h(App)
  }).$mount()
})
