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
              <th scope="col">Title:</th>
              <td scope="row">{{ user.name }}</td>
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
    userId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      user: undefined,
    };
  },
  created() {
    this.getUser();
  },
  methods: {
    async getUser() {
      try {
        this.user = await this.$store.dispatch("users/getUser", {
          userId: this.userId,
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
