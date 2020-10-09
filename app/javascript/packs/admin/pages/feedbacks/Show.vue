<template>
  <div class="mt-4">
    <div class="col-md-6 offset-md-3">
      <b-card v-if="user" header="User Profile">
        <div class="text-right">
          <router-link
            :to="{
              name: 'userEdit',
              params: { userId: user.id },
            }"
          >
            <button type="button" class="btn btn-success">
              Edit <i class="fas fa-edit"></i>
            </button>
          </router-link>
        </div>
        <table class="table mt-2">
          <tbody>
            <tr>
              <th scope="col">Id:</th>
              <td scope="row">{{ user.id }}</td>
            </tr>
            <tr>
              <th scope="col">Name:</th>
              <td scope="row">{{ user.name }}</td>
            </tr>
            <tr>
              <th scope="col">Email:</th>
              <td scope="row">{{ user.email }}</td>
            </tr>
            <tr>
              <th scope="col">Role:</th>
              <td scope="row">{{ user.role }}</td>
            </tr>
          </tbody>
        </table>
      </b-card>
    </div>
  </div>
</template>

<script>
import ApiErrorHandler from "../../mixins/ApiErrorHandler";

export default {
  mixins: [ApiErrorHandler],
  props: {
    feedbackId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      feedback: undefined,
    };
  },
  created() {
    this.getFeedback();
  },
  methods: {
    async getFeedback() {
      try {
        this.feedback = await this.$store.dispatch("feedbacks/getFeedback", {
          feedbackId: this.feedbackId,
        });
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
