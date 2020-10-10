<template>
  <div class="mt-4">
    <div class="row">
      <div class="col-12">
        <section v-if="userFeedbacks.length > 0" class="mt-2">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th scope="col">Id</th>
                <th scope="col">Title</th>
                <th scope="col">Status</th>
                <th scope="col">Questions</th>
                <th scope="col">User | Reviewer</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="feedback in userFeedbacks" :key="feedback.id">
                <th scope="row">{{ feedback.id }}</th>
                <td>{{ feedback.title }}</td>
                <td>{{ feedback.status }}</td>
                <td></td>
                <td>
                  <section v-if="feedback.usersFeedbacks.length > 0">
                    <ul v-for="(uf, i) in feedback.usersFeedbacks" :key="i">
                      <li>
                        {{ uf.user.name }}({{ uf.user.email }}) |
                        {{ uf.reviewer.name }}({{ uf.reviewer.email }}) ->
                        <strong class="text-danger">{{ uf.status }}</strong>
                      </li>
                    </ul>
                  </section>
                  <section v-else>
                    <ul>
                      <li>Not assigned yet</li>
                    </ul>
                  </section>
                </td>
                <td>
                  <router-link
                    :to="{
                      name: 'feedbackAssign',
                      params: { feedbackId: feedback.id },
                    }"
                  >
                  </router-link>
                </td>
              </tr>
            </tbody>
          </table>
        </section>
        <section v-else>
          <h3 class="text-center">Feedbacks are empty, please create</h3>
        </section>
      </div>
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
      userFeedbacks: [],
    };
  },
  created() {
    this.getUserFeedbacks();
  },
  methods: {
    async getUserFeedbacks() {
      try {
        this.userFeedbacks = await this.$store.dispatch(
          "feedbacks/getUserFeedbacks",
          { userId: this.userId }
        );
        console.log(this.userFeedbacks);
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
