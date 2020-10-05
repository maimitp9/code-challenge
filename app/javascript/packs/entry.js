import Vue from "vue";

import App from './App';

// TODO: Configure Vuex, Vue-router

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById("app")
  new Vue({
    el,
    render: h => h(App)
  })
})