<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Admin</a>
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
        <li class="nav-item active">
          <router-link
            :to="{
              name: 'users',
            }"
            class="nav-link"
            >Users
          </router-link>
        </li>
        <li class="nav-item">
          <a class="nav-link" @click="logout">Logout</a>
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
