import Vue from "vue";
import { camelizeKeys } from "humps";

// Init Vuex and store
import store from './store';

import App from './App';

import { BootstrapVue } from 'bootstrap-vue';
Vue.use(BootstrapVue)

import './assets/stylesheets/custom.scss';
import 'bootstrap-vue/dist/bootstrap-vue.css';
// TODO: Configure Vuex

import VueRouter from 'vue-router';
import routes from './admin/pages/routes';

Vue.use(VueRouter);
const router = new VueRouter({
  mode: 'history',
  routes
})

const BASE_TITLE = 'Code Challenge';

router.beforeEach((to, _from, next) => {
  // TODO: check isAuthenticated

  document.title = to.meta.title ? `${to.meta.title} | ${BASE_TITLE}` : BASE_TITLE;
  next();
})

document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById("app")
  const props = camelizeKeys(JSON.parse(el.getAttribute('data-props')), {
    deep: true
  });

  store.commit("init", {
    clientVersion: props.clientVersion
  })
  new Vue({
    el,
    router,
    render: h => h(App)
  })
})