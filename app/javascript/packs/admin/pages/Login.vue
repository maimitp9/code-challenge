<template>
  <div>
    <div class="row">
      <div class="col-md-4 offset-md-4">
        <b-alert show variant="danger" v-if="errors.length > 0" color="error">
          <ul v-for="err in errors" :key="err.message">
            <li>{{ err.message }}</li>
          </ul>
        </b-alert>
        <form @submit.prevent="submitLoginForm">
        <div class="form-group">
          <label for="email">Email address</label>
          <input type="email" v-model="loginForm.email" class="form-control">
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" v-model="loginForm.password" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary" :loading="submitting"
                  :disabled="submitting">Submit</button>
      </form>
      </div>
   </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

import ApiErrorHandler from "../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  data() {
    return {
      loginForm: {
        email: "",
        password: "",
      },
      submitting: false,
      errors: []
    };
  },
  computed: {
    ...mapState({
      apiClient: "apiClient"
    })
  },
  methods: {
    async submitLoginForm() {
      this.errors = [];
      this.submitting = true;
      console.log(this.apiClient)
      try {
        window.location.href = await this.apiClient.login(this.loginForm);
      } catch (errors) {
        if(errors.status === 400) {
          this.errors = errors.errors;
        } else {
          this.handleApiErrors(errors, {
            store: this.$store,
            router: this.$router,
          });
        }
      } finally {
        this.submitting = false;
      }
    }
  }
};
</script>