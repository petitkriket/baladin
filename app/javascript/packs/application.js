// import Vue from 'vue/dist/vue.esm'
import Vue from 'vue'
import App from '../app.vue'


document.addEventListener('DOMContentLoaded', () => {

  const el = document.body.appendChild(document.createElement('vue-app'))
  const app = new Vue({
    el,
    render: h => h(App)
  })
  console.log('VueJS', app)
})

