<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <router-link
      :to="{
        name: 'dashboard',
      }"
      class="navbar-brand"
      >Admin</router-link
    >
    <button
      class="navbar-toggler"
      type="button"
      data-toggle="collapse"
      data-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    <div id="navbarSupportedContent" class="collapse navbar-collapse">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <router-link
            :to="{
              name: 'usersList',
            }"
            class="nav-link"
            >Users
          </router-link>
        </li>
        <li class="nav-item">
          <router-link
            :to="{
              name: 'userShow',
              params: { userId: currentUser && currentUser.id },
            }"
            class="nav-link"
            >My Profile
          </router-link>
        </li>
        <li class="nav-item">
          <router-link
            :to="{
              name: 'feedbackList',
            }"
            class="nav-link"
            >Feedbacks
          </router-link>
        </li>
        <li class="nav-item">
          <router-link
            :to="{
              name: 'feedbackNew',
            }"
            class="nav-link"
            >Create Feedback
          </router-link>
        </li>
        <li class="nav-item">
          <a class="nav-link" @click="logout">Logout</a>
        </li>
        <li class="nav-item text-right">
          <strong>
            <span class="nav-link text-primary">
              Logged in User: {{ currentUser.name }}({{ currentUser.email }})
            </span>
          </strong>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
import { mapState } from "vuex";

import ApiErrorHandler from "../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  computed: {
    ...mapState({
      apiClient: "apiClient",
      currentUser: "currentUser",
    }),
  },
  methods: {
    async logout() {
      try {
        await this.apiClient.logout();
        window.location.href = "/";
      } catch (errors) {
        this.handleApiErrors(errors, {
          store: this.$store,
          router: this.$router,
        });
      }
    },
  },
};
</script>
