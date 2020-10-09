import Vue from "vue";
import { camelizeKeys } from "humps";

// Init Vuex and store
import store from "./store";

import App from "./layout/App";

import { BootstrapVue } from "bootstrap-vue";
Vue.use(BootstrapVue);

// Font Awesome
import "@fortawesome/fontawesome-free/css/all.css";

import "./assets/stylesheets/custom.scss";
import "bootstrap-vue/dist/bootstrap-vue.css";
// TODO: Configure Vuex

import VueRouter from "vue-router";
import routes from "./pages/routes";

Vue.use(VueRouter);
const router = new VueRouter({
  mode: "history",
  routes,
  linkExactActiveClass: "active",
});

const BASE_TITLE = "Admin";

router.beforeEach((to, _from, next) => {
  // TODO: check isAuthenticated

  document.title = to.meta.title
    ? `${to.meta.title} | ${BASE_TITLE}`
    : BASE_TITLE;
  next();
});

document.addEventListener("DOMContentLoaded", () => {
  const el = document.getElementById("app");
  const props = camelizeKeys(JSON.parse(el.getAttribute("data-props")), {
    deep: true,
  });

  store.commit("init", {
    clientVersion: props.clientVersion,
    currentUser: props.currentUser,
  });
  new Vue({
    el,
    router,
    store,
    render: (h) => h(App),
  });
});
