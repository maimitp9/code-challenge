<template>
  <div class="mt-4">
    <div class="col-md-6 offset-md-3">
      <b-card header="Edit User">
        <div>
          <b-alert :show="isSuccess" variant="success" dismissible>
            User successfully updated
          </b-alert>
        </div>
        <b-alert v-if="errors.length > 0" show variant="danger" color="error">
          <ul v-for="err in errors" :key="err.message">
            <li>{{ err.message }}</li>
          </ul>
        </b-alert>
        <b-form @submit.prevent="submitForm">
          <b-form-group id="input-group-1" label="Email">
            <b-form-input
              v-model="form.email"
              type="email"
              required
              placeholder="Enter email"
            ></b-form-input>
          </b-form-group>

          <b-form-group label="Employee Name:">
            <b-form-input
              v-model="form.name"
              required
              placeholder="Enter employee name"
            ></b-form-input>
          </b-form-group>

          <b-form-group label="Password">
            <b-form-input
              v-model="form.password"
              type="password"
              required
            ></b-form-input>
          </b-form-group>
          <b-form-group label="Confirm Password">
            <b-form-input
              v-model="form.password_confirmation"
              type="password"
              required
            ></b-form-input>
          </b-form-group>
          <b-form-group label="Role">
            <b-form-radio v-model="form.role" value="admin">Admin</b-form-radio>
            <b-form-radio v-model="form.role" value="employee"
              >Employee</b-form-radio
            >
          </b-form-group>

          <b-button type="submit" :disabled="submitting" variant="primary"
            >Submit</b-button
          >
          <b-button type="reset" variant="danger">Back</b-button>
        </b-form>
      </b-card>
    </div>
  </div>
</template>

<script>
import ApiErrorHandler from "../../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  props: {
    userId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      form: {
        id: null,
        email: "",
        name: "",
        password: null,
        password_confirmation: null,
        role: null,
      },
      submitting: false,
      isSuccess: false,
      errors: [],
    };
  },
  created() {
    this.getUser();
  },
  methods: {
    async getUser() {
      try {
        this.form = await this.$store.dispatch("users/getUser", {
          userId: this.userId,
        });
      } catch (errors) {
        this.handleApiErrors(errors, {
          store: this.$store,
          router: this.$router,
        });
      }
    },
    async submitForm() {
      if (this.submitting) {
        return;
      }

      this.submitting = true;
      this.errors = [];
      try {
        this.form = await this.$store.dispatch("users/updateUser", this.form);
        this.isSuccess = true;
      } catch (errors) {
        if (errors.status === 400) {
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
    },
  },
};
</script>
